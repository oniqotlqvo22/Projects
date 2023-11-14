//
//  User.swift
//  Movie-Cave
//
//  Created by Admin on 31.08.23.
//

import Foundation

//MARK: - UserModel
struct User {
    var userName: String
    var favorites: [MovieData]
    var password: String
    var firstName: String
    var lastName: String
    var isLogedIn: Bool
    var isRegistered: Bool
}

struct getUser {
    
    static var filip = User(userName: "oniq",
                            favorites: [],
                            password: "5589",
                            firstName: "Filip",
                            lastName: "Mileshkov",
                            isLogedIn: true,
                            isRegistered: true)
}
