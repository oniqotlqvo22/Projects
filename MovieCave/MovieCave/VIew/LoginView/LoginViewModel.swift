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
}

class LoginViewModel: LoginViewModelProtocol {
    
    //MARK: - Properties
    private weak var coordinator: LoginCoordinatorProtocol?
    private let apiService: MovieDBServiceProtocol
    
    //MARK: - Initializer
    init(coordinator: LoginCoordinatorProtocol, apiService: MovieDBServiceProtocol) {
        self.coordinator = coordinator
        self.apiService = apiService
    }

    //MARK: - Methods
    func getRequestToken() {
        apiService.fetchRequestToken()
    }

    func logIn() {
        coordinator?.goToTabBarController()
    }
    
}
