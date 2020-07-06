//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by metalnodeug on 06/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
