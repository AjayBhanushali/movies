//
//  MoviesModuleBuilder.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

protocol MoviesModuleBuilderProtocol: AnyObject {
    func buildModule() -> MoviesVC
}


final class MoviesModuleBuilder: MoviesModuleBuilderProtocol {
    
    func buildModule() -> MoviesVC {
        let moviesVC = MoviesVC()
        let presenter = MoviesPresenter()
        let network = NetworkAPIClient()
        let interactor = MoviesIneractor(network: network)
        let router = MoviesRouter()
        
        presenter.view = moviesVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        moviesVC.presenter = presenter
        router.viewController = moviesVC
        
        return moviesVC
    }
}

