//
//  LoginViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation

//MARK: - LoginViewModelProtocol
protocol LoginViewModelProtocol {
    func getRequestToken()
    func logIn()
    func test(with: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    
    //MARK: - Properties
    private weak var coordinator: LoginCoordinator?
    private let apiService: MovieDBServiceProtocol
    let tmdbClient = TMDBClient()
    
    //MARK: - Initializer
    init(coordinator: LoginCoordinator, apiService: MovieDBServiceProtocol) {
        self.coordinator = coordinator
        self.apiService = apiService
    }

    //MARK: - Methods
    func test(with: String, password: String) {
        tmdbClient.createSessionWithLogIn(with: with, and: password)
    }
    
    func getRequestToken() {
        apiService.fetchRequestToken()
    }

    func logIn() {
        coordinator?.goToTabBarController()
    }
    
}
