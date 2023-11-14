//
//  MoviesViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation
import Combine

//MARK: - MoviesViewModelProtocol
protocol MoviesViewModelProtocol {
    var isFavorite: CurrentValueSubject<Bool?, Never> { get }
    var movies: CurrentValueSubject<[MoviesModel]?, Never> { get }
    func favoriteMovieListOperations(with movieID: Int, for operation: Favorites)
    func changePage(nextPage: Bool)
    func filterMovies(_ genre: String)
    func searchMovies(_ text: String)
    func restoreListAfterSearch()
    func sendMovieDetails(with movieID: Int)
    var coordinator: MoviesViewCoordinator? { get }
    var popUpMessage: CurrentValueSubject<String?, Never> { get }
}

class MoviesViewModel: MoviesViewModelProtocol {
    
    //MARK: - Properties
    weak var coordinator: MoviesViewCoordinator?
    private let movieDBService: MovieDBServiceProtocol
    private var list: MoviesList
    private var currentPage = 1
    private var genreList: MovieGenreLists = .topRated
    var movies: CurrentValueSubject<[MoviesModel]?, Never> = CurrentValueSubject(nil)
    var isFavorite: CurrentValueSubject<Bool?, Never> = CurrentValueSubject(nil)
    var popUpMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    
    //MARK: - Initializer
    init(coordinator: MoviesViewCoordinator, movieDBService: MovieDBServiceProtocol, with list: MoviesList) {
        self.coordinator = coordinator
        self.movieDBService = movieDBService
        self.list = list
        fetchMovies(withFilter: genreList, on: currentPage)
    }
    
    //MARK: - Methods
    func restoreListAfterSearch() {
        currentPage = 1
        fetchMovies(withFilter: genreList, on: currentPage)
    }
    
    func changePage(nextPage: Bool) {
        guard nextPage else { return }

        currentPage += 1
        fetchMovies(withFilter: genreList, on: currentPage)
    }
    
    func filterMovies(_ filter: String) {
        switch filter {
        case Constants.mostPopularFilterButton:
            genreList = .popular
            fetchMovies(withFilter: .popular, on: currentPage)
        case Constants.upComingFilterButton:
            genreList = .upComing
            fetchMovies(withFilter: .upComing, on: currentPage)
        case Constants.ratingFilterButton:
            genreList = .topRated
            fetchMovies(withFilter: .topRated, on: currentPage)
        case Constants.newestFilterButton:
            genreList = .nowPlaying
            fetchMovies(withFilter: .nowPlaying, on: currentPage)
        default:
            break
        }
    }
    
    func searchMovies(_ text: String) {
        movieDBService.operateWithAPI(type: .movies, key: text, page: currentPage, operationType: .searchMovieByTitle, httpMethod: .get) { [weak self] (result: Result<MoviesData, MovieDBErrors>) in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.favoritesOrNot(movies: movies)
                case .failure(let error):
                    self.popUpMessage.send(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchMovies(withFilter: MovieGenreLists, on page: Int) {
        movieDBService.operateWithAPI(type: .movies, key: withFilter.movieList(), page: page, operationType: .fetchMovies, httpMethod: .get) { [weak self] (result: Result<MoviesData, MovieDBErrors>) in
            guard let self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.favoritesOrNot(movies: movies)
                case .failure(let error):
                    self.popUpMessage.send(error.localizedDescription)
                }
            }
        }
    }
    
    private func favoritesOrNot(movies: MoviesData) {
        switch self.list {
        case .allMovies:
            self.movieDBService.createMovieArray(moviesFromApi: movies.results) { moviesArray in
                self.movies.send(moviesArray)
            }
        case .favorites:
            self.movieDBService.fetchFavoriteMovies(moviesFromApi: movies.results) { favoriteMovieArray in
                self.movies.send(favoriteMovieArray)
            }
        }
    }
    
    func favoriteMovieListOperations(with movieID: Int, for operation: Favorites) {
        movieDBService.menageFavoritesMovies(with: movieID, for: operation)
    }
    
    func sendMovieDetails(with movieID: Int) {
        coordinator?.loadMoviesDetailsView(with: movieID)
    }
    
}
