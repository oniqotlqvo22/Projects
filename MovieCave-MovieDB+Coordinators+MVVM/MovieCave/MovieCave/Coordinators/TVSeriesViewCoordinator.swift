//
//  AddMovieCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol TVSeriesViewCoordinatorProtocol {
    
    /// Loads the TVSeriesDetailsView and ViewModel to display additional
    /// information for a selected TV series.
    /// - Parameter ID: The ID of the selected TV series to load details for.
    func loadSeriesDetailsView(with ID: Int)
}

class TVSeriesViewCoordinator: Coordinator, TVSeriesViewCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let tvSeriesVC = TVSeriesViewController.initFromStoryBoard() else { return }

        
        tvSeriesVC.viewModel = TVSeriesViewModel(coordinator: self, movieDBService: MovieDBService())
        identifier = Constants.tvSeriesViewCoordinatorID
        navController.navigationBar.prefersLargeTitles = false
        navController.pushViewController(tvSeriesVC, animated: true)
    }
    
    func viewFlow(viewController: UIViewController) {

    }

    func loadSeriesDetailsView(with ID: Int) {
        let seriesCoordinator = TVSeriesDetailsCoordinator(navController: navController, id: ID)
        parentCoordinator?.addChildCoordinator(seriesCoordinator)
        seriesCoordinator.start()
    }
}
