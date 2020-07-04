//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by MeTaLnOdEuG on 02/07/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []


    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
   @objc func dismissVC() {
    dismiss(animated: true)
    }

    private func configureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GHFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GHFRepoItemVC(user: user), to: self.itemViewOne)
                    self.add(childVC: GHFFollowerItemVC(user: user), to: self.itemViewTwo)
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
                }
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: GHFText.badAlert, message: error.rawValue, buttonTitle: "Ok")

            }
        }
    }

    private func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140

        itemViews = [headerView,itemViewOne,itemViewTwo, dateLabel]

        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
