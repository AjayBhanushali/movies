//
//  MovieDetailsRouter.swift
//  AssignmentBMS
//
//  Created by Ajay on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

final class MovieDetailsRouter: MovieDetailsRouterInput {
    weak var viewController: UIViewController?
    
    func showMovieDetails(with movie: Movie) {
        let movieDetailsVC = MovieDetailsModuleBuilder().buildModule(with: movie)
        viewController?.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
