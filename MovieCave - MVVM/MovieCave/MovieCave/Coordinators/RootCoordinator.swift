//
//  AppCoordinator.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import UIKit

//MARK: - AppCoordinatorProtocol
protocol RootCoordinatorProtocol {
    
    /// Shows the login flow.
    func showLoginFlow()
    
    /// Loads the login view and removes the child coordinators.
    func loadLogInPage()
}

class RootCoordinator: Coordinator, RootCoordinatorProtocol {
    
    //MARK: - Properties
    private var rootNavController: UINavigationController
        
    //MARK: - Initializer
    init(rootNavController: UINavigationController) {
        self.rootNavController = rootNavController
    }

    //MARK: - Methods
    override func start() {
        parentCoordinator = self
        showLoginFlow()
    }
    
    //MARK: - RootCoordinatorProtocol
    func showLoginFlow() {
        let logInCoordinator = LoginCoordinator(navController: rootNavController)
        
        parentCoordinator?.addChildCoordinator(logInCoordinator)
        logInCoordinator.start()
    }
    
    func loadLogInPage() {
        rootNavController.viewControllers.removeAll()
        removeAllChildCoordinators()
        showLoginFlow()
    }
    
}
