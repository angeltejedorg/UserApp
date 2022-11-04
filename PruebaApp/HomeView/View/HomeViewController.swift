//
//  ViewController.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import UIKit

class HomeViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    private let viewmodel = HomeViewModel()
    
    private var shouldShowList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.loadData()
        setupBinders()
        setupStyles()
        tableView.register(UINib(nibName: Constants.userItemCellNibName, bundle: nil), forCellReuseIdentifier: Constants.userItemCellIdentifier)
        tableView.register(UINib(nibName: Constants.notFoundCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.notFoundCellNibName)
    }
    
    func setupBinders() {
        viewmodel.usersList.bind { [weak self] users in
            guard let userList = users  else { return }
            if userList.isEmpty {
                self?.viewmodel.getUsersList()
                return
            }
            self?.tableView.reloadData()
        }
        
        viewmodel.filteredUserList.bind { [weak self] filteredUsers in
            guard let filteredUsers = filteredUsers  else { return }
         
            if filteredUsers.isEmpty {
                self?.shouldShowList = false
                self?.tableView.reloadData()
                return
            }
            self?.shouldShowList = true
            self?.viewmodel.setFilteredUsers(filteredUsers)
        }
    }
    
    func setupStyles() {
        tableView.allowsSelection = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.primaryColor
        
        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = titleAttribute
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
 }

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldShowList ? viewmodel.usersList.value?.count ?? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = viewmodel.getUser(at: indexPath.row)
        
        if shouldShowList {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userItemCellIdentifier, for: indexPath) as! UserItemCell
            cell.setupCell(user: user)
            cell.userInfoDelegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notFoundCellIdentifier, for: indexPath) as! NotFoundCell
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        
        if searchBarText.isEmpty {
            shouldShowList = true
            viewmodel.loadData()
            return
        }
        viewmodel.searchUser(searchBarText)
        tableView.reloadData()
    }
}

extension HomeViewController: UserInfoDelegate {
    func buildView(with user: User?) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.postsViewControllerIdentifier) as! PostsViewController
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

