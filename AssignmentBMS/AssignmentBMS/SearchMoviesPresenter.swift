//
//  SearchMoviesPresenter.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

final class SearchMoviesPresenter: SearchMoviesModuleInput, SearchMoviesViewOutput {
    
    var view: SearchMoviesViewInput?
    
    var interactor: SearchMoviesInteractorInput!
    
    var router: SearchMoviesRouterInput!
    
    var moviesViewModel: MoviesViewModel!
    var searchResultViewModel: MoviesViewModel!
    
    init(_ _moviesViewModel: MoviesViewModel) {
        moviesViewModel = _moviesViewModel
    }
    
    func searchMovies(for movieName: String) {
        print(movieName)
        let searchedMovies = SearchAlgorithm().shareMoviesThatStartsWith(searchString: movieName, movies: moviesViewModel.movies)
        searchResultViewModel = MoviesViewModel(_movies: searchedMovies)
        view?.displayMovies(with: searchResultViewModel)
    }
    
    func onViewDidLoad() {
        if let movies = CacheManager.shared.fetchAllMovies() {
            self.searchResultViewModel = MoviesViewModel(_movies: movies)
            self.view?.displayMovies(with: self.searchResultViewModel)
        }
    }
    
    func clearData() {
        
    }
    
    func didSelectMovie(at index: Int) {
        let movie = searchResultViewModel.movies[index]
        CacheManager.shared.insert(movie: movie)
        router.showMovieDetails(with: movie)
    }
}
