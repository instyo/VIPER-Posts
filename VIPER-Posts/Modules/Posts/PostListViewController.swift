//
//  PostListViewController.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import UIKit

class PostListViewController: UIViewController {
    var presenter: PostListPresenterInput!
    
    private let tableView = UITableView()
    private var posts: [PostItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

extension PostListViewController: PostListPresenterOutput {
    func showPosts(_ posts: [PostItem]) {
        DispatchQueue.main.async { [weak self] in
            self?.posts = posts
            self?.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

extension PostListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}
