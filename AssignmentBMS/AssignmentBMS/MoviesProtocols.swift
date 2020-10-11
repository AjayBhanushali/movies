//
//  MoviesProtocols.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation
import UIKit

//MARK: BaseViewInput

protocol BaseViewInput: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension BaseViewInput where Self: UIViewController {
    func showSpinner() {
        view.showSpinner()
    }
    
    func hideSpinner() {
        view.hideSpinner()
    }
}

//MARK: View
protocol MoviesViewInput: BaseViewInput {
    var presenter: MoviesViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func displayMovies(with viewModel: MoviesViewModel)
    func insertMovies(with viewModel: MoviesViewModel, at indexPaths: [IndexPath])
    func resetViews()
}

//MARK: Presenter
protocol MoviesModuleInput: AnyObject {
    var view: MoviesViewInput? { get set }
    var interactor: MoviesInteractorInput! { get set }
    var router: MoviesRouterInput! { get set }
}

protocol MoviesViewOutput: AnyObject {
    func getMovies()
    var isMoreDataAvailable: Bool { get }
    func clearData()
    func didSelectMovie(at index: Int)
    func tappedOnSearch()
}

protocol MoviesInteractorOutput: AnyObject {
    func getMoviesSuccess(_ moviesBase: MoviesBase)
    func getMoviesError(_ error: NetworkError)
}


//MARK: InteractorInput
protocol MoviesInteractorInput: AnyObject {
    var presenter: MoviesInteractorOutput? { get set }
    func loadMovies(for pageNum: Int)
}

//MARK: Router
protocol MoviesRouterInput: AnyObject {
    func showMovieDetails(with movie: Movie)
    func openSearchView(with viewModel: MoviesViewModel)
}
