//
//  MovieDetailsBuilder.swift
//  AssignmentBMS
//
//  Created by Ajay on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

protocol MovieDetailsModuleBuilderProtocol {
    func buildModule(with movie: Movie) -> MovieDetailsVC
}

final class MovieDetailsModuleBuilder: MovieDetailsModuleBuilderProtocol {
    
    func buildModule(with movie: Movie) -> MovieDetailsVC {
        
        let movieDetailsVC = MovieDetailsVC()
        let presenter = MovieDetailsPresenter(movie)
        let network = NetworkAPIClient()
        let interactor = MovieDetailsIneractor(network: network)
        let router = MovieDetailsRouter()
        
        presenter.view = movieDetailsVC
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        movieDetailsVC.presenter = presenter
        router.viewController = movieDetailsVC
        
        return movieDetailsVC
    }
}
