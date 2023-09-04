//
//  MovieScreenViewModel.swift
//  Movie-Cave
//
//  Created by Admin on 1.09.23.
//

import Foundation
import Combine

class MovieScreenViewModel {
    
    var movies: [Movie]
    var filteredMovies: CurrentValueSubject<[Movie]?, Never> = CurrentValueSubject(nil)
    var searchedMovies: CurrentValueSubject<[Movie]?, Never> = CurrentValueSubject(nil)
    
    init(movies: [Movie]) {
        self.movies = movies
        filteredMovies.send(movies)
    }
    
    func reloadMovies() {
        print(movies.count)
        filteredMovies.send(movies)
    }
    
    func searchMovies(_ text: String) {
        filteredMovies.send(searchMovies(query: text))
    }
    
    func changeValue(_ movie: Movie) {
        movies.removeAll(where: {$0.movieTitle == movie.movieTitle})
        movies.append(movie)
    }
    
    
    func filterMovies(_ genre: String) {
        switch genre {
        case "Most popular":
            filteredMovies.send(sortMoviesByViews())
        case "Longest":
            filteredMovies.send(sortMoviesByDuration())
        case "Raiting":
            filteredMovies.send(sortMoviesByRaiting())
        case "Newest":
            filteredMovies.send(sortMoviesByDate())
        default:
            break
        }
    }
    
    private func searchMovies(query: String) -> [Movie] {
      let filtered = movies.filter { movie in
          return movie.movieTitle.localizedCaseInsensitiveContains(query)
      }
      return filtered
    }

    private func sortMoviesByViews() -> [Movie] {
        let sortedMovies = movies.sorted { (movie1, movie2) -> Bool in
            return movie1.viewed > movie2.viewed
        }
        
        return sortedMovies
    }
    
    private func sortMoviesByDate() -> [Movie] {
        let sortedMovies = movies.sorted { (movie1, movie2) -> Bool in
            return movie1.date > movie2.date
        }
        
        return sortedMovies
    }
    
    private func sortMoviesByRaiting() -> [Movie] {
        let sortedMovies = movies.sorted { (movie1, movie2) -> Bool in
            return movie1.raiting > movie2.raiting
        }
        
        return sortedMovies
    }
    
    private func sortMoviesByDuration() -> [Movie] {
        let sortedMovies = movies.sorted { (movie1, movie2) -> Bool in
            return movie1.duration > movie2.duration
        }
        
        return sortedMovies
    }
    
}
