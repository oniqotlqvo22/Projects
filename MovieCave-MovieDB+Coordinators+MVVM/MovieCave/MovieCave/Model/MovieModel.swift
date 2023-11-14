//
//  MovieModel.swift
//  MovieCave
//
//  Created by Admin on 3.10.23.
//

import Foundation

struct MoviesData: Codable {
    var page: Int
    var results: [MovieResults]
}

struct MovieResults: Codable {
    var id: Int
    var originalTitle: String
    var overview: String
    var genreIds: [Int]
    var posterPath: String?
}

struct MovieDetailsData: Codable {
    var genres: [Genres]
    var id: Int
    var releaseDate: String
    var runtime: Int
    var voteAverage: Double
    var voteCount: Int
    var backdropPath: String?
    var posterPath: String?
    var originalTitle: String
    var overview: String
    
    struct Genres: Codable {
        var id: Int
        var name: String
    }
}

struct MovieVideos: Codable {
    var results: [VideoResults]
    
    struct VideoResults: Codable {
        var name: String
        var key: String
        var site: String
        var type: String
        var id: String
    }
}

struct MovieCast: Codable {
    var cast: [CastDetails]
    
    struct CastDetails: Codable {
        var name: String
        var profilePath: String?
    }
}

struct MoviesModel {
    var movieResults: MovieResults
    var isFavorite: Bool
}

enum MoviesList {
    case favorites
    case allMovies
}

enum MovieGenreLists {
    case topRated
    case popular
    case nowPlaying
    case upComing
    
    func movieList() -> String {
        switch self {
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        case .nowPlaying:
            return "now_playing"
        case .upComing:
            return "upcoming"
        }
    }
}
