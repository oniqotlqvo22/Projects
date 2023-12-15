//
//  MainTabBarViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation

//MARK: - MainTabBarViewModelProtocl
protocol MainTabBarViewModelProtocol {
    func tabBarItemPressed(tabBar: String)
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    //MARK: - Properties
    weak var coordinator: TabBarCoordinatorProtocol?
    
    //MARK: - Initializer
    init(coordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func tabBarItemPressed(tabBar: String) {
        coordinator?.tabBarItemClicked(itemName: tabBar)
    }
    
}
