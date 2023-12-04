//
//  TVSeriesDetailsCoordinator.swift
//  MovieCave
//
//  Created by Admin on 16.10.23.
//

import UIKit

class TVSeriesDetailsCoordinator: Coordinator, DetailsScreenCoordinatorProtocol {
    
    private var navController: UINavigationController
    private var id: Int
    
    init(navController: UINavigationController, id: Int) {
        self.navController = navController
        self.id = id
    }
    
    override func start() {
        guard let movieDetailsVC = DetailsScreenViewController.initFromStoryBoard() else { return }

        movieDetailsVC.viewModel = DetailsScreenViewModel(mediaType: .tvSeries, id: id, coordinator: self, apiService: MovieDBService())
        identifier = Constants.tvSeriesDetailsCoordinatorID
        navController.pushViewController(movieDetailsVC, animated: true)
    }
    
}
