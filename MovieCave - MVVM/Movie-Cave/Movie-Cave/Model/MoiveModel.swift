//
//  MoiveModel.swift
//  Movie-Cave
//
//  Created by Admin on 31.08.23.
//

import Foundation
import UIKit

struct Movie {
    var movieTitle: String
    var genre: [String]
    var duration: Double
    var favorite: Bool
    var cast: [String]
    var describtion: String
    var image: UIImage
    var raiting: Double
    var date: Date
    var viewed: Double
}

struct GetMovies {
    
    static var yasuke = Movie(movieTitle: "Yasuke",
                              genre: ["Drama", "Adventure", "Thriller", "Animation", "Fantasy", "Action"],
                              duration: 24,
                              favorite: false,
                              cast: ["Creator - Lesean Thomas", "LaKeith Stanfield", "Maya Tanida", "William Christopher Stephens", "Darren Criss", "Alexander W. Hunter"],
                              describtion: "He came from Africa and fought alongside a mighty feudal lord in brutal 16th century Japan. They called him the Black Samurai, and he became a legend.Loosely based on the historical figure of the same name, a warrior of African descent who served under Japanese daimyo Oda Nobunaga during the Sengoku period of samurai conflict in 16th century Japan.",
                              image: UIImage(named: "yasuke") ?? UIImage(),
                              raiting: 7.5,
                              date: Date(timeIntervalSince1970: 35),
                              viewed: 123)
    
    static var dune = Movie(movieTitle: "Dune",
                            genre: ["Drama", "Adventure", "Thriller", "Animation", "Fantasy", "Action"],
                            duration: 191,
                            favorite: false,
                            cast: ["Dune1", "Dune2", "Dune3", "Dune4", "Dune5", "Dune6"],
                            describtion: "Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune Dune ",
                            image: UIImage(named: "dune") ?? UIImage(),
                            raiting: 8.1,
                            date: Date(timeIntervalSince1970: 40),
                            viewed: 53)
    
    static var oppenheimer = Movie(movieTitle: "Oppenheimer",
                                   genre: ["Drama", "Adventure", "Thriller", "Animation", "Fantasy", "Action"],
                                   duration: 219,
                                   favorite: false,
                                   cast: ["Oppenheimer1", "Oppenheimer2", "Oppenheimer3", "Oppenheimer4", "Oppenheimer15", "Oppenheimer156"],
                                   describtion: "Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer Oppenheimer ",
                                   image: UIImage(named: "oppenheimer") ?? UIImage(),
                                   raiting: 5.3,
                                   date: Date(timeIntervalSince1970: 42),
                                   viewed: 1666)
    
    static var parasite = Movie(movieTitle: "Parasite",
                                genre: ["Drama", "Thriller", "Mystery"],
                                duration: 143,
                                favorite: false,
                                cast: ["Korean1", "Korean2", "Korean3", "Korean4", "Korean5", ],
                                describtion: "Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite Parasite ",
                                image: UIImage(named: "parasite") ?? UIImage(),
                                raiting: 6.7,
                                date: Date(timeIntervalSince1970: 39),
                                viewed: 12)
    
    static var guardiansOfGalaxy = Movie(movieTitle: "Guardians of the Galaxy",
                                         genre: ["Drama", "Adventure", "Thriller", "Animation", "Fantasy", "Action"],
                                         duration: 132,
                                         favorite: false,
                                         cast: ["Groot1", "Groot2", "Groot13", "Groot15", "Groot11", "Groot16", "Groot111"],
                                         describtion: "Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians Guardians ",
                                         image: UIImage(named: "guardians") ?? UIImage(),
                                         raiting: 8.8,
                                         date: Date(timeIntervalSince1970: 56),
                                         viewed: 5)
    
    static var rurouniKenshin = Movie(movieTitle: "Rurouni Kenshin",
                                      genre: ["Drama", "Adventure", "Thriller", "Animation", "Fantasy", "Action"],
                                      duration: 21,
                                      favorite: false,
                                      cast: ["Kenshin1", "Kenshin2", "Kenshin3", "Kenshin4", "Kenshin1123", "Kenshin14",],
                                      describtion: "Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin Kenshin ",
                                      image: UIImage(named: "ruronin") ?? UIImage(),
                                      raiting: 7.4,
                                      date: Date(timeIntervalSince1970: 55),
                                      viewed: 223)
    
}
