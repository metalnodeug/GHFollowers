//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by MeTaLnOdEuG on 02/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
   @objc func dismissVC() {
    dismiss(animated: true)
    }

}
