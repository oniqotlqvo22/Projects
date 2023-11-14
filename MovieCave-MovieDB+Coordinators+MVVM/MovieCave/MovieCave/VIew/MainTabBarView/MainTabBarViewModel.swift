//
//  MainTabBarViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation

//MARK: - MainTabBarViewModelProtocl
protocol MainTabBarViewModelProtocol {
    func getItNow(tabBar: String)
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    
    //MARK: - Properties
    weak var coordinator: TabBarCoordinator?
    
    //MARK: - Initializer
    init(coordinator: TabBarCoordinator) {
        self.coordinator = coordinator
    }
    
    func getItNow(tabBar: String) {
//        coordinator?.tabBarItemClicked(itemName: tabBar)
    }
}
