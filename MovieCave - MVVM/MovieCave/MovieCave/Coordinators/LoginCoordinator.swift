//
//  LoginCoordinator.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    
    /// Navigates to the tab bar controller.
    func goToTabBarController()
}

class LoginCoordinator: Coordinator, LoginCoordinatorDelegate {
    
    //MARK: - Properties
    private var navController: UINavigationController
    weak var delegate: LoginCoordinatorDelegate?
    
    //MARK: - Initialization
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    //MARK: - Override Methods
    override func start() {
        guard let logInVC = LoginViewController.initFromStoryBoard() else { return }
        
        identifier = Constants.loginCoordinatorID
        logInVC.viewModel = LoginViewModel(coordinator: self, apiService: MovieDBService())
        navController.pushViewController(logInVC, animated: true)
    }
    
    //MARK: - LoginCoordinatorDelegate
    func goToTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(rootNavController: navController)
        parentCoordinator?.addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}
