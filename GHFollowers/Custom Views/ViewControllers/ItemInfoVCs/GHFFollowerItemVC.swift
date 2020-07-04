//
//  GHFFollowerItemVC.swift
//  GHFollowers
//
//  Created by metalnodeug on 04/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//


import UIKit

class GHFFollowerItemVC: GHFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
