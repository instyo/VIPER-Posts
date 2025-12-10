//
//  PostDetailViewController.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import UIKit

class PostDetailViewController: UIViewController {
    var presenter: PostDetailPresenterInput!
    let id: Int
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView()

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad(id: id)
        setupContent()
        setupLoadingIndicator()
    }
    
    func setupContent() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),

            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

extension PostDetailViewController: PostDetailPresenterOutput {
    func showPostDetail(_ post: PostItem) {
        self.loadingIndicator.stopAnimating()
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
    }
    
    func showError(_ message: String) {
        self.loadingIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
