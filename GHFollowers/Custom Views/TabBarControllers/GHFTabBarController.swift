//
//  GHFTabBarController.swift
//  GHFollowers
//
//  Created by metalnodeug on 06/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class GHFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoriteNavigationController()]
    }

    private func createSearchNavigationController() -> UINavigationController {
        // If you will set the title create ViewController not RootViewController
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = .init(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController:searchVC)
    }

    private func createFavoriteNavigationController() -> UINavigationController {
        // If you will set the title create ViewController not RootViewController
        let favoritesListVC = FavoritesListVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = .init(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController:favoritesListVC)
    }

}
