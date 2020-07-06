//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by MeTaLnOdEuG on 06/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

    func removedExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
