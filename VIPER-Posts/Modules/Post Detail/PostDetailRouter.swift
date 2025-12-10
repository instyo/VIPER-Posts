//
//  PostDetailRouter.swift
//  VIPER-Posts
//
//  Created by ikhwan on 10/12/25.
//

import UIKit

protocol PostDetailRouterInput: AnyObject {
    static func createModule(id: Int) -> UIViewController
}

class PostDetailRouter: PostDetailRouterInput {
    weak var viewController: UIViewController?
    
    static func createModule(id: Int) -> UIViewController {
        let repository = PostRepositoryImpl.shared
        let view = PostDetailViewController(id: id)
        let presenter = PostDetailPresenter()
        let interactor = PostDetailInteractor(repository: repository)
        let router = PostDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
