//
//  PostsViewController.swift
//  PruebaApp
//
//  Created by angel.tejedore on 3/11/22.
//

import UIKit

class PostsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewmodel = PostsViewModel()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBinders()
        viewmodel.loadPostsData(userId: user?.id ?? 0)
    
        tableView.register(UINib(nibName: Constants.postsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.postsCellIdentifier)
        setupUI()
    }
    
    func setupUI(){
        nameLabel.text = user?.name
        emailLabel.text = user?.email
        phoneLabel.text = user?.phone
    }
    
    func setupBinders() {
        viewmodel.postList.bind { [weak self] postsList in
            
            guard let postsList = postsList else { return }
            if postsList.isEmpty {
                self?.viewmodel.getPostsList(userId: 1)
                return
            }
            self?.tableView.reloadData()
        }
    }

}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.postList.value?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewmodel.getPost(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.postsCellIdentifier, for: indexPath) as! PostsCell
        cell.setupCell(title: post?.title, body: post?.body)
        return cell
    }
}
