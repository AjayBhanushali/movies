//
//  MoviesRouter.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class MoviesRouter: MoviesRouterInput {
    weak var viewController: UIViewController?
    
    func showMovieDetails(with movie: Movie) {
//        let movieDetailsVC = MovieDetailsModuleBuilder().buildModule(with: movie)
//        viewController?.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func openSearchView(with viewModel: MoviesViewModel) {
//        let searchMoviesVC = SearchMoviesModuleBuilder().buildModule(with: viewModel)
//        viewController?.navigationController?.pushViewController(searchMoviesVC, animated: true)
    }
}
