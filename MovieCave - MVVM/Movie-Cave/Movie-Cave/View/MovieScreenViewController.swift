//
//  ViewController.swift
//  Movie-Cave
//
//  Created by Admin on 29.08.23.
//

import UIKit
import Combine

class MovieScreenViewController: UIViewController {

    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var movieListView: MovieListView!
    @IBOutlet weak var filterBarView: FilterBarView!
    private let viewModel = MovieScreenViewModel(movies: [
        GetMovies.yasuke, GetMovies.dune, GetMovies.rurouniKenshin, GetMovies.guardiansOfGalaxy, GetMovies.oppenheimer, GetMovies.parasite
    ])
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBarView.filterBarDelegate = self
        
        viewModel.filteredMovies.sink { [weak self] filteredMovies in
            guard let filteredMovies else { return }
            
            self?.movieListView.movies = filteredMovies
        }.store(in: &cancellables)
        
        viewModel.searchedMovies.sink { [weak self] searchedMovies in
            guard let searchedMovies else { return }
            
            self?.movieListView.movies = searchedMovies
        }.store(in: &cancellables)
    }
    
}

extension MovieScreenViewController: FilterBarViewDelegate {
    
    func searchBar(_ text: String) {
        viewModel.searchMovies(text)
    }
    
    
    func genreButton(_ genre: String) {
        viewModel.filterMovies(genre)
    }
}
