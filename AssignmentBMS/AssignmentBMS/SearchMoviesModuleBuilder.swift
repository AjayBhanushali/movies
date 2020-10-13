//
//  SearchMoviesModuleBuilder.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

protocol SearchMoviesModuleBuilderProtocol {
    func buildModule(with moviesViewModel: MoviesViewModel) -> SearchMoviesVC
}

final class SearchMoviesModuleBuilder: SearchMoviesModuleBuilderProtocol {
    
    func buildModule(with moviesViewModel: MoviesViewModel) -> SearchMoviesVC {
        
        let searchMoviesVC = SearchMoviesVC()
        let presenter = SearchMoviesPresenter(moviesViewModel)
        let router = SearchMoviesRouter()
        
        presenter.view = searchMoviesVC
        presenter.router = router
        
        searchMoviesVC.presenter = presenter
        router.viewController = searchMoviesVC
        
        return searchMoviesVC
    }
}
