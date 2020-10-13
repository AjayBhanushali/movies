//
//  MovieDetailsProtocol.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

//MARK: View
protocol MovieDetailsViewInput: BaseViewInput {
    var presenter: MovieDetailsViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func reloadView(at index: Int, viewModel: MovieDetailsViewModel)
}

//MARK: Presenter
protocol MovieDetailsModuleInput: AnyObject {
    var view: MovieDetailsViewInput? { get set }
    var interactor: MovieDetailsInteractorInput! { get set }
    var router: MovieDetailsRouterInput! { get set }
}

protocol MovieDetailsViewOutput: AnyObject {
    func getMovieDetails()
    func didSelectMovie(at index: Int)
}

protocol MovieDetailsInteractorOutput: AnyObject {
    func getSynpopsisSuccess(_ synopsisBase: MovieSynopsisBase)
    func getReviewsSuccess(_ reviewsBase: MovieReviewsBase)
    func getCreditsSuccess(_ creditsBase: Credits)
    func getMoviesSuccess(_ moviesBase: MoviesBase)
    func getError(_ error: NetworkError)
}


//MARK: InteractorInput
protocol MovieDetailsInteractorInput: AnyObject {
    var presenter: MovieDetailsInteractorOutput? { get set }
    func loadMovieDetails(for id: Int)
}

//MARK: Router
protocol MovieDetailsRouterInput: AnyObject {
    func showMovieDetails(with movie: Movie)
}
