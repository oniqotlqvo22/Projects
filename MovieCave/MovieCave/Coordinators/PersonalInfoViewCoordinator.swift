//
//  PersonalInfoViewCoordinator.swift
//  MovieCave
//
//  Created by Admin on 26.10.23.
//

import UIKit

protocol PersonalInfoViewCoordinatorProtocol: AnyObject {
    
    /// Delocates the current coordinator.
    func delocateCoordinator()
}

class PersonalInfoViewCoordinator: Coordinator, PersonalInfoViewCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let personalInfoVC = PersonalInfoViewController.initFromStoryBoard() else { return }
        
        personalInfoVC.viewModel = PersonalInfoViewModel(coordinator: self, apiService: MovieDBService())
        identifier = Constants.personalInfoCoordinatorID
        navController.pushViewController(personalInfoVC, animated: true)
    }
    
    func delocateCoordinator() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
}
