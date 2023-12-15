//
//  AddMovieViewController.swift
//  MovieCave
//
//  Created by Admin on 21.09.23.
//

import UIKit
import Combine

class TVSeriesViewController: UIViewController, SpinnerProtocol {

    //MARK: - IBOutlets
    @IBOutlet weak var tvSeriesView: ReusableListView!
    
    //MARK: - Properties
    var viewModel: TVSeriesViewModelProtocol?
    var spinnerView: UIView?
    private var popUp: PopUpView!
    private var isNexPageLoaded = false
    private var lastSearchTxt = ""
    private var cancellables: [AnyCancellable] = []
    private var tvSeries: [TVSeriesResults] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tvSeriesView.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tvSeriesView.collectionView.register(CollectionViewReusableCell.self,
                                        forCellWithReuseIdentifier: Constants.MoviesCollectionCellidentifier)

        tvSeriesView.filterButtons(buttonTitles: [Constants.popularTVSeriesFilterButton,
                                                  Constants.airingTodayTVSeriesFilterButton,
                                                  Constants.onTheAirTVSeriesFilterButton,
                                                  Constants.topRatedTVSeriesFilterButton])
        tvSeriesView.filterButtonsDelegate = self
        tvSeriesView.collectionView.delegate = self
        tvSeriesView.collectionView.dataSource = self
        tvSeriesView.searchBar.delegate = self
        setUpBinders()
    }
    
    //MARK: - Private Methods
    private func setUpBinders() {
        viewModel?.series.sink { [weak self] series in
            guard let self,
                  let series else { return }
            
            self.removeSpinner()
            self.tvSeries = series
        }.store(in: &cancellables)
    
        viewModel?.popUpMessage.sink { [weak self] message in
            guard let self,
                  let message else { return }
            
            self.popUp = PopUpView(frame: self.view.bounds, inVC: self, messageLabelText: message)
            self.view.addSubview(self.popUp)
        }.store(in: &cancellables)
    }
    
}

//MARK: - FilterButtonsDelegate
extension TVSeriesViewController: FilterButtonsDelegate {
    func buttonClicked(with buttonTitle: String) {
        viewModel?.filterSeries(buttonTitle)
    }
}

//MARK: - CollectionViewDelegate & DataSource & DelegateFlowLayout
extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - (height - (height / 2.5)) {
            
            if !isNexPageLoaded {
                isNexPageLoaded = true
                showSpinner()
                viewModel?.changePage(nextPage: isNexPageLoaded)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.loadNextPage()
                    self.tvSeriesView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                }
            }
        } else if offsetY < -200 {
            
            if !isNexPageLoaded {
                isNexPageLoaded = true
                showSpinner()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.loadFirstPage()
                    self.tvSeriesView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                }
            }
        }
    }
    
    private func loadFirstPage() {
        isNexPageLoaded = false
        viewModel?.restoreListAfterSearch()
    }

    private func loadNextPage() {
        isNexPageLoaded = false
        viewModel?.changePage(nextPage: isNexPageLoaded)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        viewModel?.sendSeriesDetails(with: tvSeries[indexPath.row].id)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MoviesCollectionCellidentifier,
                                                            for: indexPath) as? CollectionViewReusableCell else {
            return CollectionViewReusableCell()
        }

        cell.tvSeries = tvSeries[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing: CGFloat = (numberOfItemsPerRow - 1) * spacing
        let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}

//MARK: - UISearchBarDelegate
extension TVSeriesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }

        viewModel?.searchTVSeries(with: searchBarText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchBar.text != "" else {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeNetworkCall), object: lastSearchTxt)
            viewModel?.restoreListAfterSearch()
            return
        }

        if lastSearchTxt.isEmpty {
            lastSearchTxt = searchText
        }

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeNetworkCall), object: lastSearchTxt)
        lastSearchTxt = searchText
        self.perform(#selector(self.makeNetworkCall), with: searchText, afterDelay: 0.5)
    }

    @objc private func makeNetworkCall(sender: String) {

        viewModel?.searchTVSeries(with: sender)
    }

}
