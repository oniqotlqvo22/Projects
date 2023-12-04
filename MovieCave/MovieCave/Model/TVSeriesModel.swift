//
//  TVSeriesModel.swift
//  MovieCave
//
//  Created by Admin on 13.10.23.
//

import Foundation

struct TVSeriesData: Codable {
    var page: Int
    var results: [TVSeriesResults]
}

struct TVSeriesResults: Codable {
    var id: Int
    var name: String
    var overview: String
    var genreIds: [Int]
    var posterPath: String?
}

struct TVSeriesVideosData: Codable {
    var results: [VideoResults]
    
    struct VideoResults: Codable {
        var name: String
        var key: String
        var site: String
        var type: String
        var id: String
    }
}

struct TVSeriesCastData: Codable {
    var cast: [CastDetails]
    
    struct CastDetails: Codable {
        var name: String
        var profilePath: String?
    }
}

struct TVSeriesDetailsData: Codable {
    var genres: [Genres]
    var id: Int
    var firstAirDate: String
    var name: String
    var backdropPath: String?
    var posterPath: String?
    var voteAverage: Double
    var voteCount: Double
    var overview: String
    var runtime: Int?

    struct Genres: Codable {
        var id: Int
        var name: String
    }
}

enum TVSeriesLists {
    case topRated
    case popular
    case airingToday
    case onTheAir
    
    func tvSeriesList() -> String {
        switch self {
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        case .airingToday:
            return "airing_today"
        case .onTheAir:
            return "on_the_air"
        }
    }
}
