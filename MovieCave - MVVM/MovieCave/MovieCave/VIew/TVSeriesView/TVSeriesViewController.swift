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
    @IBOutlet private weak var tvSeriesView: ReusableListViewProtocol!
    
    //MARK: - Properties
    var viewModel: TVSeriesViewModelProtocol?
    var spinnerView: UIView?
    private var popUp: PopUpView!
    private var cancellables: [AnyCancellable] = []

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tvSeriesView.filterButtons(buttonTitles: [Constants.popularTVSeriesFilterButton,
                                                  Constants.airingTodayTVSeriesFilterButton,
                                                  Constants.onTheAirTVSeriesFilterButton,
                                                  Constants.topRatedTVSeriesFilterButton])
        setUpBinders()
        setUpDelegates()
    }
    
    //MARK: - Private Methods
    private func setUpBinders() {
        viewModel?.resetPosition.sink { [weak self] makeReset in
            guard let self,
                  makeReset else { return }
            
            self.showSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.tvSeriesView.resetCollectionViewPosition(with: 0, on: 0, animation: true)
            }
            
        }.store(in: &cancellables)
        
        viewModel?.fetchingDataSuccession.sink { [weak self] success in
            guard let self,
                  success else { return }
            
            self.removeSpinner()
            DispatchQueue.main.async {
                self.tvSeriesView.reloadCollectionViewSections()
            }
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

//MARK: - TVSeriesReusableViewDelegates Setup
extension TVSeriesViewController {

    private func setUpDelegates() {
        guard let viewModel else { return }
        
        tvSeriesView.setUpFilterButtonDelegate(for: self)
        tvSeriesView.setUpCollectionView(with: viewModel.dataSource, with: viewModel.dataSource)
        tvSeriesView.setUpSearchBar(with: self)
    }
    
}

//MARK: - UISearchBarDelegate
extension TVSeriesViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }

        viewModel?.performSearch(with: searchBarText)
    }
    
}

//MARK: - SearchBarTextFieldTextPublisherDelegate
extension TVSeriesViewController: SearchBarTextFieldTextPublisherDelegate {

    func searchBarTextPublished(text: String) {
        viewModel?.performSearch(with: text)
    }
    
}
