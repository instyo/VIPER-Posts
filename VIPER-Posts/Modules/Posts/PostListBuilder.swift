//
//  PostListBuilder.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import UIKit

enum PostListBuilder {
    static func build(repository: PostRepository) -> UIViewController {
        let view = PostListViewController()
        let presenter = PostListPresenter()
        let interactor = PostListInteractor(repository: repository)
        let router = PostListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
