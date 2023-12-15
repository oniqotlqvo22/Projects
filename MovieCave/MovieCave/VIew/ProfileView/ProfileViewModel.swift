//
//  ProfileViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation
import Combine

//MARK: - ProfileViewModelProtocol
protocol ProfileViewModelProtocol {
    func editPersonalInfo()
    func goToFavoriteMovies()
    func logOut()
    var userInfoMessage: CurrentValueSubject<String?, Never> { get }
}

class ProfileViewModel: ProfileViewModelProtocol {

    //MARK: - Properties
    private weak var coordinator: ProfileViewCoordinatorProtocol?
    var userInfoMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    
    //MARK: - Initializer
    init(coordinator: ProfileViewCoordinatorProtocol, userInfoMessage: String) {
        self.coordinator = coordinator
        self.userInfoMessage.send(userInfoMessage)
    }

    //MARK: - Methods
    func editPersonalInfo() {
        coordinator?.loadPersonalInfoView()
    }
    
    func goToFavoriteMovies() {
        coordinator?.loadFavoriteMoviesView()
    }

    func logOut() {
        coordinator?.logOut()
    }
    
}
