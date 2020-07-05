//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by metalnodeug on 27/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getFavorites()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func getFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                break
            }
        }
    }

}
