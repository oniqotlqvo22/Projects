//
//  MovieDetailsViewModel.swift
//  Movie-Cave
//
//  Created by Admin on 6.09.23.
//

import Foundation
import Combine

protocol MovieDetailsViewModelProtocol {
    
    /// The currently selected movie
    var movie: MovieData? { get set }
    
    /// The stream to provide updates to the movie detail view
    var movieDetail: CurrentValueSubject<MovieData?, Never> { get }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    //MARK: - Properties
    var movie: MovieData?
    var movieDetail: CurrentValueSubject<MovieData?, Never> = CurrentValueSubject(nil)
    
    //MARK: - Initializer
    init(movie: MovieData) {
        self.movie = movie
        movieDetail.send(movie)
    }
    
}
