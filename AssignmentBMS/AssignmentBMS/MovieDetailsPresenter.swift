//
//  MovieDetailsPresenter.swift
//  AssignmentBMS
//
//  Created by Ajay on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

final class MovieDetailsPresenter: MovieDetailsModuleInput {
    var view: MovieDetailsViewInput?
    var interactor: MovieDetailsInteractorInput!
    var router: MovieDetailsRouterInput!
    var movie: Movie
    var movieDetailsViewModel = MovieDetailsViewModel()
    
    init(_ _movie: Movie) {
        movie = _movie
        movieDetailsViewModel.movie = movie
    }
}

extension MovieDetailsPresenter: MovieDetailsViewOutput {
    func didSelectMovie(at index: Int) {
        let movie = movieDetailsViewModel.similarMovies[index]
        router.showMovieDetails(with: movie)
    }
    
    func getMovieDetails() {
        DispatchQueue.main.async {
            self.view?.reloadView(at: 0, viewModel: self.movieDetailsViewModel)
        }
        interactor.loadMovieDetails(for: movie.id!)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutput {
    
    func getSynpopsisSuccess(_ synopsisBase: MovieSynopsisBase) {
        self.movieDetailsViewModel.synopsis = synopsisBase
        DispatchQueue.main.async {
            self.view?.reloadView(at: 1, viewModel: self.movieDetailsViewModel)
        }
    }
    
    func getMovieVideosisSuccess(_ movieVideosBase: MovieVideosBase) {
        self.movieDetailsViewModel.videos = movieVideosBase.results
    }
    
    func getCreditsSuccess(_ creditsBase: Credits) {
        self.movieDetailsViewModel.credits = creditsBase
        DispatchQueue.main.async {
            self.view?.reloadView(at: 2, viewModel: self.movieDetailsViewModel)
        }
        
    }
    
    func getReviewsSuccess(_ reviewsBase: MovieReviewsBase) {
        self.movieDetailsViewModel.reviews = reviewsBase.results!
        
        DispatchQueue.main.async {
            self.view?.reloadView(at: 3, viewModel: self.movieDetailsViewModel)
        }
    }
    
    
    
    func getMoviesSuccess(_ moviesBase: MoviesBase) {
        self.movieDetailsViewModel.similarMovies = moviesBase.results!
        DispatchQueue.main.async {
            self.view?.reloadView(at: 4, viewModel: self.movieDetailsViewModel)
        }
    }
    
    func getError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.error(error.description))
        }
    }
}
