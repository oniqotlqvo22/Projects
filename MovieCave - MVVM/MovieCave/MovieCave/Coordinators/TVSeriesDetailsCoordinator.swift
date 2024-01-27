//
//  TVSeriesDetailsCoordinator.swift
//  MovieCave
//
//  Created by Admin on 16.10.23.
//

import UIKit

class TVSeriesDetailsCoordinator: Coordinator {
    
    private var navController: UINavigationController
    private var seriesID: Int
    
    init(navController: UINavigationController, seriesID: Int) {
        self.navController = navController
        self.seriesID = seriesID
    }
    
    override func start() {
        guard let movieDetailsVC = TvSeriesDetailsViewController.initFromStoryBoard() else { return }
        
        movieDetailsVC.viewModel = TvSeriesDetailsViewModel(mediaID: seriesID, coordinator: self, apiService: MovieDBService(), with: .tvSeries)
        identifier = Constants.tvSeriesDetailsCoordinatorID
        navController.pushViewController(movieDetailsVC, animated: true)
    }
    
}
