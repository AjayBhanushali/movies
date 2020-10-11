//
//  MovieDetailsViewModel.swift
//  AssignmentBMS
//
//  Created by Ajay on 12/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel {
    var synopsis: MovieSynopsisBase?
    var credits: Credits?
    var reviews: [MovieReview] = []
    var similarMovies: [Movie] = []
}

extension MovieDetailsViewModel {

    func posterURL(_ index: Int) -> URL? {
        guard !similarMovies.isEmpty else {
            fatalError("No movie available")
        }
        
        guard let path = similarMovies[index].poster_path, let url = URL(string: APIConstants.movieDBImagesBaseURL + path) else {
            return nil
        }
        
        return url
    }
}
