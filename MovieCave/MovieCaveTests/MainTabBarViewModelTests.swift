//
//  MainTabBarViewModelTests.swift
//  MovieCaveTests
//
//  Created by Admin on 2.12.23.
//

import XCTest
@testable import MovieCave

final class MainTabBarViewModelTests: XCTestCase {
    
    var coordinator: TabBarCoordinator!
    var viewModel: MainTabBarViewModelProtocol!

    override func setUp() {
        coordinator = TabBarCoordinator(rootNavController: UINavigationController())
        viewModel = MainTabBarViewModel(coordinator: coordinator)
    }

    override func tearDown() {
        coordinator = nil
        viewModel = nil
    }
    
    func test_tabBarItemPressed_HappyCase() {
        // Given
        
        // When
        viewModel.tabBarItemPressed(tabBar: "test")
        
        // Then
        
    }

    func test_tabBarItemPressed_SadCase() {
        // Given
        
        // When
        viewModel.tabBarItemPressed(tabBar: "test")
        
        // Tthen
    }
    
}
