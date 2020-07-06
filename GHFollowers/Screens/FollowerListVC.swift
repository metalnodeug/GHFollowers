//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by metalnodeug on 28/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var hasMoreFollowers = true
    var page = 1
    var isSearching = false

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        configureSearchController()
        getFollower(username: username, page: page)
        configureDataSource()
        updateData(on: followers)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func getFollower(username: String, page: Int) {
        self.showLoadingView()

        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)

                if self.followers.isEmpty {
                    let message = GHFText.emptyStateMessage
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: GHFText.badAlert, message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }

    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    @objc func addButtonTapped() {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)

                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }

                    guard let error = error else {
                        self.presentGHFAlertOnMainThread(title: "Success", message: "You have success favorited this user", buttonTitle: "Ok")
                        return
                    }

                    self.presentGHFAlertOnMainThread(title: GHFError.somethingWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
                }

            case .failure(let error):
                self.presentGHFAlertOnMainThread(title: GHFError.somethingWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

extension FollowerListVC: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollower(username: username, page: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]

        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollower(username: username, page: page)
    }
}
