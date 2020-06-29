//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by metalnodeug on 29/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentGHFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GHFAlertVC(title: title, message: message, buttonLabel: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
