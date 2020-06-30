//
//  GHFAvatarImageView.swift
//  GHFollowers
//
//  Created by metalnodeug on 30/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class GHFAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: GHFImage.placeHolder)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
