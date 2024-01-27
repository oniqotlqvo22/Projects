//
//  MainTabBarViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation

//MARK: - MainTabBarViewModelProtocl
protocol MainTabBarViewModelProtocol {
    /// Handles the press event of a tab bar item with the specified tab bar name.
    /// - Parameter tabBar: The name of the tab bar item that was pressed.
    func tabBarItemPressed(tabBar: String)
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    //MARK: - Properties
    weak var coordinator: TabBarCoordinatorDelegate?
    
    //MARK: - Initializer
    init(coordinator: TabBarCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tabBarItemPressed(tabBar: String) {
        coordinator?.tabBarItemClicked(itemName: tabBar)
    }
    
}
