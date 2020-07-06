//
//  GHFFollowerItemVC.swift
//  GHFollowers
//
//  Created by metalnodeug on 04/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//


import UIKit

protocol GHFFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GHFFollowerItemVC: GHFItemInfoVC {

    weak var delegate: GHFFollowerItemVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    init(user: User, delegate: GHFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
