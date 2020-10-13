//
//  MoviesInteractor.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

final class MoviesIneractor: MoviesInteractorInput {

    let network: NetworkService
    weak var presenter: MoviesInteractorOutput?
    
    init(network: NetworkService) {
        self.network = network
    }
    
    //MARK: Load Movies
    func loadMovies(for pageNum: Int) {
        let endPoint = MovieDBAPI.getMoviesFor(page: pageNum)
        network.dataRequest(endPoint, objectType: MoviesBase.self) { [weak self] (result: Result<MoviesBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getMoviesSuccess(response)
            case let .failure(error):
                self.presenter?.getMoviesError(error)
            }
        }
    }
}
