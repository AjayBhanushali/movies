//
//  MoviesPresenter.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

final class MoviesPresenter: MoviesModuleInput, MoviesViewOutput, MoviesInteractorOutput {
    
    weak var view: MoviesViewInput?
    var interactor: MoviesInteractorInput!
    var router: MoviesRouterInput!
    
    var moviesViewModel: MoviesViewModel!
    
    var pageNum = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    var totalPages = Constants.defaultPageNum
    
    var isMoreDataAvailable: Bool {
        guard totalPages != 0 else {
            return true
        }
        return pageNum < totalPages
    }
    
    //MARK: MoviesViewOutput

    func getMovies() {
        guard isMoreDataAvailable else {
            view?.changeViewState(.content)
            return
        }
        view?.changeViewState(.loading)
        pageNum += 1
        interactor.loadMovies(for: pageNum)
    }

    func didSelectMovie(at index: Int) {
        let movie = moviesViewModel.movies[index]
        router.showMovieDetails(with: movie)
    }
    
    func tappedOnSearch() {
        router.openSearchView(with: moviesViewModel)
    }
    func clearData() {
        pageNum = Constants.defaultPageNum
        totalCount = Constants.defaultTotalCount
        totalPages = Constants.defaultTotalCount
        moviesViewModel = nil
        view?.resetViews()
        view?.changeViewState(.none)
    }

    // MARK: MoviesInteractorOutput
    func getMoviesSuccess(_ moviesBase: MoviesBase) {
        guard let movies = moviesBase.results else { return }
        
        if totalCount == Constants.defaultTotalCount {
            moviesViewModel = MoviesViewModel(_movies: movies)
            totalCount = movies.count
            
            if let _totalPages = moviesBase.total_pages {
                totalPages = _totalPages
            }

            DispatchQueue.main.async { [unowned self] in
                self.view?.displayMovies(with: self.moviesViewModel)
                self.view?.changeViewState(.content)
            }
        } else {
            insertMoreMovies(with: movies)
        }
    }
    
    func getMoviesError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.error(error.description))
        }
    }
    
    //MARK: Photo Seach Success
    fileprivate func insertMoreMovies(with movies: [Movie]) {
        let previousCount = totalCount
        totalCount += movies.count
        moviesViewModel.addMoreMovies(movies)
        let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
            return IndexPath(item: $0, section: 0)
        }
        DispatchQueue.main.async { [unowned self] in
            self.view?.insertMovies(with: self.moviesViewModel, at: indexPaths)
            self.view?.changeViewState(.content)
        }
    }
}
