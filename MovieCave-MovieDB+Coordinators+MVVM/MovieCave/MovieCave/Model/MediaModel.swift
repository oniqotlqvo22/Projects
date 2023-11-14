//
//  MediaModel.swift
//  MovieCave
//
//  Created by Admin on 19.10.23.
//

import Foundation

struct MediaDetails {
    var title: String
    var overview: String
    var id: Int
    var poster: String
    var bigPoster: String
    var avrgVote: String
    var releaseDate: String
    var gernes: [String]
}

struct MediaCast {
    var name: String
    var poster: String?

}

struct MediaVideos {
    var key: String
    var name: String
}
