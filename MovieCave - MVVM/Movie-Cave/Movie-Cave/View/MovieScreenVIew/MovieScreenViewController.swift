//
//  ViewController.swift
//  Movie-Cave
//
//  Created by Admin on 29.08.23.
//

import UIKit
import Combine

class MovieScreenViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var movieListView: MovieListView!
    @IBOutlet weak var filterBarView: FilterBarView!
    
    //MARK: - Properties
    private let coreData = CoreDataManager.shared
    private lazy var viewModel: MovieScreenViewModelProtocol = {
      return MovieScreenViewModel(coreData: coreData)
    }()
    private var cancellables: [AnyCancellable] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBarView.filterBarDelegate = self
        movieListView.delegate = self
        navigationView.delegate = self
        viewModel.filteredMovies
            .sink { [weak self] filteredMovies in
            guard let filteredMovies else { return }
            
            self?.movieListView.movies = filteredMovies
        }.store(in: &cancellables)
    }
    
}

//MARK: - NavigationViewDelegate
extension MovieScreenViewController: NavigationViewDelegate {
    
    func buttonTapped() {
        guard let addMovieVC = AddMovieViewController.initFromStoryBoard() else { return }

        addMovieVC.movieCompletion = { [weak self] movie in
            
            self?.viewModel.movie = movie
        }
        navigationController?.pushViewController(addMovieVC, animated: true)
    }
    
}

//MARK: - MovieListViewDelegate
extension MovieScreenViewController: MovieListViewDelegate {
    
    func movieTapedFromCell(for movie: MovieData) {
        guard let movieDetailsVC = MovieDetailsViewController.initFromStoryBoard() else { return }

        movieDetailsVC.movie = movie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }

    func favoriteButtonTapped(in cell: MoviesCollectionViewCell) {
        viewModel.changeValue()
    }
    
}

//MARK: - FilterBarViewDelegate
extension MovieScreenViewController: FilterBarViewDelegate {
    func searchBarDidClear() {
        viewModel.reloadMovies()
    }
    
    func searchBar(_ text: String) {
        viewModel.searchMovies(text)
    }
    
    
    func genreButton(_ genre: String) {
        viewModel.filterMovies(genre)
    }
}


