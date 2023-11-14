//
//  LoginCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    
    /// Navigates to the tab bar controller.
    func goToTabBarController()
}

class LoginCoordinator: Coordinator, LoginCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let logInVC = LoginViewController.initFromStoryBoard() else { return }
        
        identifier = Constants.loginCoordinatorID
        logInVC.viewModel = LoginViewModel(coordinator: self, apiService: MovieDBService())
        navController.pushViewController(logInVC, animated: true)
    }
    
    func goToTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(rootNavController: navController)
        parentCoordinator?.addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}
