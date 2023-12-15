//
//  MockCoordinator.swift
//  MovieCaveTests
//
//  Created by Admin on 4.12.23.
//

import UIKit
@testable import MovieCave

enum CoordinatorSuccessType {
    case happy
    case sad
}
class MockCoordinator: Coordinator, ProfileViewCoordinatorProtocol, TabBarCoordinatorProtocol, LoginCoordinatorProtocol, PersonalInfoViewCoordinatorProtocol {

    let navController = UINavigationController()
    var successType: CoordinatorSuccessType
    var tabBarItemName: String?
    
    init(successType: CoordinatorSuccessType) {
        self.successType = successType
    }
    
    //MARK: - PersonalInfoViewCoordinatorProtocol
    func delocateCoordinator() {
        switch successType {
        case .happy:
            childCoordinators = []
            identifier = nil
        case .sad:
            let personalInfoCoord = PersonalInfoViewCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(personalInfoCoord)
            identifier = "Personal coordinator"
        }
    }
    

    //MARK: - LoginViewCoordinator
    func goToTabBarController() {
        switch successType {
        case .happy:
            let tabBarCoortinator = TabBarCoordinator(rootNavController: navController)
            parentCoordinator?.addChildCoordinator(tabBarCoortinator)
        case .sad:
            break
        }
    }
    
    //MARK: - MainTabBarCoordinator Protocol
    func tabBarItemClicked(itemName: String) {
        switch successType {
        case .happy:
            tabBarItemName = itemName
        case .sad:
            tabBarItemName = nil
        }
    }
    
    
    //MARK: - ProfileCoordinatorProtocol
    func loadFavoriteMoviesView() {
        switch successType {
        case .happy:
            let favoriteMoviesCoordinator = MoviesViewCoordinator(navController: navController, with: .favorites)
            parentCoordinator?.addChildCoordinator(favoriteMoviesCoordinator)
        case .sad:
            break
        }
    }
    
    func loadPersonalInfoView() {
        switch successType {
        case .happy:
            let personalInfoCoordinator = PersonalInfoViewCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(personalInfoCoordinator)
        case .sad:
            break
        }
    }
    
    func logOut() {
        switch successType {
        case .happy:
            removeAllChildCoordinators()
        case .sad:
            let personalInfoCoordinator = PersonalInfoViewCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(personalInfoCoordinator)
        }
    }
    
}
