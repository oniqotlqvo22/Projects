//
//  LoginViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation

//MARK: - LoginViewModelProtocol
protocol LoginViewModelProtocol {
    /// Requests a token for authentication.
    func getRequestToken()
    
    /// Performs the login process.
    func logIn()
}

class LoginViewModel: LoginViewModelProtocol {
    
    //MARK: - Properties
    private weak var logInCoordinatorDelegate: LoginCoordinatorDelegate?
    private let apiService: MovieDBServiceProtocol
    
    //MARK: - Initializer
    init(coordinator: LoginCoordinatorDelegate, apiService: MovieDBServiceProtocol) {
        self.logInCoordinatorDelegate = coordinator
        self.apiService = apiService
    }

    //MARK: - Methods
    func getRequestToken() {
        apiService.fetchRequestToken()
    }

    func logIn() {
        logInCoordinatorDelegate?.goToTabBarController()
    }
    
}
