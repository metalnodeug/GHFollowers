//
//  GHFRepoItemVC.swift
//  GHFollowers
//
//  Created by metalnodeug on 04/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class GHFRepoItemVC: GHFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
