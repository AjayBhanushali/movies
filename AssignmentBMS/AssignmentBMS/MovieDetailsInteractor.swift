//
//  MovieDetailsInteractor.swift
//  AssignmentBMS
//
//  Created by Ajay on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

final class MovieDetailsIneractor: MovieDetailsInteractorInput {
    
    let network: NetworkService
    weak var presenter: MovieDetailsInteractorOutput?
    
    init(network: NetworkService) {
        self.network = network
    }
    
    //MARK: Load Movies
    func loadMovieDetails(for id: Int) {
        loadSynopsis(for: id)
        loadVideos(for: id)
        loadReviews(for: id, pageNum: 1)
        loadCredits(for: id)
        loadMovies(for: id, pageNum: 1)
    }
    
    private func loadSynopsis(for id: Int) {
        let endPoint = MovieDBAPI.getMovieSynopsis(id: id)
        network.dataRequest(endPoint, objectType: MovieSynopsisBase.self) { [weak self] (result: Result<MovieSynopsisBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getSynpopsisSuccess(response)
            case let .failure(error):
                self.presenter?.getError(error)
            }
        }
    }
    
    private func loadVideos(for id: Int) {
        let endPoint = MovieDBAPI.getVideosFor(id: id)
        network.dataRequest(endPoint, objectType: MovieVideosBase.self) { [weak self] (result: Result<MovieVideosBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getMovieVideosisSuccess(response)
            case let .failure(error):
                self.presenter?.getError(error)
            }
        }
    }
    
    private func loadReviews(for id: Int, pageNum: Int) {
        let endPoint = MovieDBAPI.getMovieReviews(id: id, page: pageNum)
        network.dataRequest(endPoint, objectType: MovieReviewsBase.self) { [weak self] (result: Result<MovieReviewsBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getReviewsSuccess(response)
            case let .failure(error):
                self.presenter?.getError(error)
            }
        }
    }
    private func loadCredits(for id: Int) {
        let endPoint = MovieDBAPI.getCredits(id: id)
        network.dataRequest(endPoint, objectType: Credits.self) { [weak self] (result: Result<Credits, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getCreditsSuccess(response)
            case let .failure(error):
                self.presenter?.getError(error)
            }
        }
    }
    
    private func loadMovies(for id: Int, pageNum: Int) {
        let endPoint = MovieDBAPI.getSimilarMovies(id: id, page: pageNum)
        network.dataRequest(endPoint, objectType: MoviesBase.self) { [weak self] (result: Result<MoviesBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getMoviesSuccess(response)
            case let .failure(error):
                self.presenter?.getError(error)
            }
        }
    }
}
