//
//  SearchMoviesProtocol.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation
import UIKit

//MARK: View
protocol SearchMoviesViewInput: BaseViewInput {
    var presenter: SearchMoviesViewOutput! { get set }
    func displayMovies(with viewModel: MoviesViewModel)
    
    func changeViewState(_ state: ViewState)
    func resetViews()
}

//MARK: Presenter
protocol SearchMoviesModuleInput: AnyObject {
    var view: SearchMoviesViewInput? { get set }
    var interactor: SearchMoviesInteractorInput! { get set }
    var router: SearchMoviesRouterInput! { get set }
}

protocol SearchMoviesViewOutput: AnyObject {
    func searchMovies(for movieName: String)
    func onViewDidLoad()
    func didSelectMovie(at index: Int)
    func clearData()
}

protocol SearchMoviesInteractorOutput: AnyObject {
    
}

//MARK: InteractorInput
protocol SearchMoviesInteractorInput: AnyObject {
    
}

//MARK: Router
protocol SearchMoviesRouterInput: AnyObject {
    func dismiss()
    
    func showMovieDetails(with movie: Movie)
}
