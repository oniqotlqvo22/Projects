//
//  AppCoordinator.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import UIKit

//MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol {
    
    /// Shows the login flow.
    func showLoginFlow()
}

class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    
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
