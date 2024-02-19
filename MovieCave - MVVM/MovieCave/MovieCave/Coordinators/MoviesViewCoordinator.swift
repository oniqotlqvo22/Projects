//
//  MoviesViewCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol MoviesViewCoordinatorDelegate: AnyObject {
    
    /// Loads the MovieDetailsView and ViewModel to display additional
    /// information for a selected movie.
    /// - Parameter ID: The ID of the selected movie to load details for.
    func loadMoviesDetailsView(with movieID: Int)
    
    /// Removes the coordinator from coordinator  hierarchy.
    func dellocateCoordinator()
}

class MoviesViewCoordinator: Coordinator, MoviesViewCoordinatorDelegate {
    
    //MARK: - Properties
    private var navController: UINavigationController
    private var list: MoviesList
    
    //MARK: - Initialization
    init(navController: UINavigationController, with list: MoviesList) {
        self.navController = navController
        self.list = list
    }
    
    //MARK: - Override methods
    override func start() {
        guard let moviesVC = MoviesViewController.initFromStoryBoard() else { return }

        moviesVC.viewModel = MoviesViewModel(moviesViewCoordinatorDelegate: self,
                                             movieDBService: MovieDBService(),
                                             dataSource: CollectionViewDataSource(items: []),
                                             with: list,
                                             with: .topRated,
                                             currentPage: Constants.firstPage)
        identifier = Constants.moviesViewCoordinatorID
        navController.navigationBar.prefersLargeTitles = false
        navController.pushViewController(moviesVC, animated: true)
    }
    
    //MARK: - MoviesViewCoordinatorDelegate
    func loadMoviesDetailsView(with movieID: Int) {
        let moviesCoordinator = MovieDetailsViewCoordinator(navController: navController, movieID: movieID)
        parentCoordinator?.addChildCoordinator(moviesCoordinator)
        moviesCoordinator.start()
    }
    
    func dellocateCoordinator() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
