//
//  MainTabControllerViewController.swift
//  MovieCave
//
//  Created by Admin on 21.09.23.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    //MARK: - Properties
    var viewModel: MainTabBarViewModelProtocol?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.tintColor = .systemIndigo
        tabBar.backgroundColor = .systemGray3
        tabBar.unselectedItemTintColor = .darkGray
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title else { return }
        
    }
}
