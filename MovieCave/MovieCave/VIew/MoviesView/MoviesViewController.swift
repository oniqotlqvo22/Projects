//
//  MoviesViewController.swift
//  MovieCave
//
//  Created by Admin on 21.09.23.
//

import UIKit
import Combine

class MoviesViewController: UIViewController, SpinnerProtocol {
    
    //MARK: - IBOutlets
    @IBOutlet weak var movieView: ReusableListView!
    
    //MARK: - Properties
    var viewModel: MoviesViewModelProtocol?
    var spinnerView: UIView?
    private var favoriteButton: UIButton!
    private var popUp: PopUpView!
    private var isNexPageLoaded = false
    private var lastSearchTxt = ""
    private var cancellables: [AnyCancellable] = []
    private var movies: [MoviesModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieView.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        movieView.filterButtons(buttonTitles: [Constants.mostPopularFilterButton,
                                                  Constants.upComingFilterButton,
                                                  Constants.ratingFilterButton,
                                                  Constants.newestFilterButton])
        movieView.filterButtonsDelegate = self
        movieView.collectionView.delegate = self
        movieView.collectionView.dataSource = self
        movieView.searchBar.delegate = self
        movieView.collectionView.register(CollectionViewReusableCell.self,
                                        forCellWithReuseIdentifier: Constants.MoviesCollectionCellidentifier)
        setUpBinders()
    }
    
    //MARK: - Private Methods
    private func setUpBinders() {
        viewModel?.movies.sink { [weak self] movies in
            guard let self,
                  let movies else { return}
            
            self.removeSpinner()
            self.movies = movies
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
extension MoviesViewController: FilterButtonsDelegate {
    func buttonClicked(with buttonTitle: String) {
        viewModel?.filterMovies(buttonTitle)
    }
}

//MARK: - CollectionViewDelegate & DataSource & DelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - (height - (height / 2)) {
            
            if !isNexPageLoaded {
                isNexPageLoaded = true
                showSpinner()
                viewModel?.changePage(nextPage: isNexPageLoaded)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.loadNextPage()
                    self.movieView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                }
            }
        } else if offsetY < -200 {
            
            if !isNexPageLoaded {
                isNexPageLoaded = true
                showSpinner()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.loadFirstPage()
                    self.movieView.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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

        viewModel?.sendMovieDetails(with: movies[indexPath.row].movieResults.id)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MoviesCollectionCellidentifier,
                                                            for: indexPath) as? CollectionViewReusableCell else {
            return CollectionViewReusableCell()
        }

        favoriteButton = UIButton(frame: CGRect(x:1, y:1, width:Constants.favoriteButtonWidth, height:Constants.favoriteButtonHeight))
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        cell.addSubview(favoriteButton)
        cell.movie = movies[indexPath.row]

        return cell
    }

    @objc func favoriteButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview as? CollectionViewReusableCell,
              let indexPath = movieView.collectionView.indexPath(for: cell) else { return }

        movies[indexPath.row].isFavorite
        ? viewModel?.favoriteMovieListOperations(with: movies[indexPath.row].movieResults.id, for: .removeFromFavorites)
        : viewModel?.favoriteMovieListOperations(with: movies[indexPath.row].movieResults.id, for: .addToFavorites)
        movies[indexPath.row].isFavorite.toggle()
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
extension MoviesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }

        viewModel?.searchMovies(searchBarText)
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

        viewModel?.searchMovies(sender)
    }

}
