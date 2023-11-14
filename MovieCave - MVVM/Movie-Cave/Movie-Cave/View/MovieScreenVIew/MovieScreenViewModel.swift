//
//  MovieScreenViewModel.swift
//  Movie-Cave
//
//  Created by Admin on 1.09.23.
//

import Foundation
import Combine

protocol MovieScreenViewModelProtocol {
    
    /// Reloads the movies data from the data source
    func reloadMovies()
    
    /// Searches the movies and returns the results matching the text
    /// - Parameter text: The search text
    func searchMovies(_ text: String)
    
    /// Updates a movie favorite value
    func changeValue()
    
    /// Filters the movies by genre
    /// - Parameter genre: The genre to filter by
    func filterMovies(_ genre: String)
    
    /// The stream of filtered movies to display
    var filteredMovies: CurrentValueSubject<[MovieData]?, Never> { get }
    
    /// The currently selected movie
    var movie: MovieData? { get set }
}

class MovieScreenViewModel: MovieScreenViewModelProtocol {

    //MARK: - Properties
    private var moviesArray = [MovieData]()
    private let coreData: CoreDataManager
    var filteredMovies: CurrentValueSubject<[MovieData]?, Never> = CurrentValueSubject(nil)
    var movie: MovieData? {
        didSet {
            moviesArray.append(movie ?? MovieData())
            filteredMovies.send(moviesArray)
        }
    }
    
    //MARK: - Intializer
    init(coreData: CoreDataManager) {
        self.coreData = coreData
        moviesArray = coreData.loadMovies() ?? []
        filteredMovies.send(moviesArray)
    }
    
    //MARK: - MovieScreenViewModelProtocol
    func reloadMovies() {
        filteredMovies.send(moviesArray)
    }
    
    func searchMovies(_ text: String) {
        moviesArray.removeAll(where: {$0.movieTitle == movie?.movieTitle})
        filteredMovies.send(searchMovies(query: text))
    }
    
    func changeValue() {
        coreData.saveMovieData()
        filteredMovies.send(moviesArray)
    }
    
    
    func filterMovies(_ genre: String) {
        switch genre {
        case Constants.mostPopularFilterButton:
            filteredMovies.send(sortMoviesByViews())
        case Constants.longestFilterButton:
            filteredMovies.send(sortMoviesByDuration())
        case Constants.ratingFilterButton:
            filteredMovies.send(sortMoviesByRaiting())
        case Constants.newestFilterButton:
            filteredMovies.send(sortMoviesByDate())
        default:
            break
        }
    }

    //MARK: - Private Methods
    private func searchMovies(query: String) -> [MovieData] {
      let filter = moviesArray.filter { movieData in
        if let title = movieData.movieTitle {
          return title.localizedStandardContains(query)
        } else {
          return false
        }
      }
      return filter
    }

    private func sortMoviesByViews() -> [MovieData] {
        let sortedMovies = moviesArray.sorted { (movie1, movie2) -> Bool in

            return movie1.viewed > movie2.viewed
        }
        
        return sortedMovies
    }

    private func sortMoviesByDate() -> [MovieData] {
        let sortedMovies = moviesArray.sorted { (movie1, movie2) -> Bool in
            return movie1.date > movie2.date
        }

        return sortedMovies
    }

    private func sortMoviesByRaiting() -> [MovieData] {
        let sortedMovies = moviesArray.sorted { (movie1, movie2) -> Bool in

            return movie1.rating > movie2.rating
        }

        return sortedMovies
    }

    private func sortMoviesByDuration() -> [MovieData] {
        let sortedMovies = moviesArray.sorted { (movie1, movie2) -> Bool in

            return movie1.duration > movie2.duration
        }

        return sortedMovies
    }

}
