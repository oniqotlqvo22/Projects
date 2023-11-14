//
//  MovieDetailsViewCoordinator.swift
//  MovieCave
//
//  Created by Admin on 3.10.23.
//

import UIKit

class MovieDetailsViewCoordinator: Coordinator, DetailsScreenCoordinatorProtocol {
    
    private var navController: UINavigationController
    private var id: Int
    
    init(navController: UINavigationController, id: Int) {
        self.navController = navController
        self.id = id
    }
    
    override func start() {
        guard let movieDetailsVC = DetailsScreenViewController.initFromStoryBoard() else { return }

        movieDetailsVC.viewModel = DetailsScreenViewModel(mediaType: .movies, id: id, coordinator: self, apiService: MovieDBService())
        identifier = Constants.movieDetailsCoordinatorID
        navController.pushViewController(movieDetailsVC, animated: true)
    }
    
}
