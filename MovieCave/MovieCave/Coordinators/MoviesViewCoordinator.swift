//
//  MoviesViewCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol MoviesViewCoordinatorProtocol {
    
    /// Loads the MovieDetailsView and ViewModel to display additional
    /// information for a selected movie.
    /// - Parameter ID: The ID of the selected movie to load details for.
    func loadMoviesDetailsView(with ID: Int)
}

class MoviesViewCoordinator: Coordinator, MoviesViewCoordinatorProtocol {
    
    private var navController: UINavigationController
    private var list: MoviesList
    
    init(navController: UINavigationController, with list: MoviesList) {
        self.navController = navController
        self.list = list
    }
    
    override func start() {
        guard let moviesVC = MoviesViewController.initFromStoryBoard() else { return }

        moviesVC.viewModel = MoviesViewModel(coordinator: self, movieDBService: MovieDBService(), with: list, with: .topRated)
        identifier = Constants.moviesViewCoordinatorID
        navController.navigationBar.prefersLargeTitles = false
        navController.pushViewController(moviesVC, animated: true)
    }
    
    func loadMoviesDetailsView(with ID: Int) {
        let moviesCoordinator = MovieDetailsViewCoordinator(navController: navController, id: ID)
        parentCoordinator?.addChildCoordinator(moviesCoordinator)
        moviesCoordinator.start()
    }
    
}
