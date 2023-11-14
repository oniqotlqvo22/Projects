//
//  ProfileViewCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol ProfileViewCoordinatorProtocol {
    
    /// Loads the Favorites Movies view to display the user's favorite movies list.
    func loadFavoriteMoviesView()
    
    /// Loads the Personal Info view to display and edit the user's account details.
    func loadPersonalInfoView()
    
    /// Logs out the user by dismissing the Profile flow.
    func logOut()
}

class ProfileViewCoordinator: Coordinator, ProfileViewCoordinatorProtocol {

    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let profileVC = ProfileViewController.initFromStoryBoard() else { return }

        profileVC.viewModel = ProfileViewModel(coordinator: self, userInfoMessage: "Hello User")
        identifier = Constants.profileViewCoordinatorID
        navController.pushViewController(profileVC, animated: true)
    }
    
    func loadFavoriteMoviesView() {
        let favoriteMoviesCoordinator = MoviesViewCoordinator(navController: navController, with: .favorites)
        parentCoordinator?.addChildCoordinator(favoriteMoviesCoordinator)
        favoriteMoviesCoordinator.start()
    }
    
    func loadPersonalInfoView() {
        let personalInfoCoordinator = PersonalInfoViewCoordinator(navController: navController)
        parentCoordinator?.addChildCoordinator(personalInfoCoordinator)
        personalInfoCoordinator.start()
    }
    
    func logOut() {
        guard let paretn = firstParent(of: AppCoordinator.self) else { return }

        paretn.loadLogInPage()
    }
    
}
