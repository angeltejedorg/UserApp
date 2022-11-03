//
//  ViewController.swift
//  PruebaApp
//
//  Created by angel.tejedore on 2/11/22.
//

import UIKit

class HomeViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewmodel = HomeViewModel()
    private var isUserFound = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
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
            if filteredUsers.isEmpty && self?.searchBar.text == ""{
                self?.viewmodel.loadData()
                return
            } else if filteredUsers.isEmpty {
                self?.isUserFound = false
                self?.tableView.reloadData()
                return
            }
            self?.isUserFound = true
            self?.viewmodel.setFilteredUsers(filteredUsers)
        }
    }
    
    
    func setupStyles() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.primaryColor
        
        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = titleAttribute
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
            self.viewmodel.searchUser(searchBarText)
        tableView.reloadData()
        
    }
    
}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewmodel.deleteItem(index: indexPath.row)
    }
}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isUserFound ? viewmodel.usersList.value?.count ?? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = viewmodel.getUser(at: indexPath.row)
        
        if isUserFound {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userItemCellIdentifier, for: indexPath) as! UserItemCellTableViewCell
            cell.setupCell(name: user?.name, phone: user?.name, email: user?.name)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notFoundCellIdentifier, for: indexPath) as! NotFoundCell
        return cell
    }
    
}

