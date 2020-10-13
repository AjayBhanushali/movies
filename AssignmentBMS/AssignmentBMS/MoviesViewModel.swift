//
//  MoviesViewModel.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

struct MoviesViewModel {
    
    var movies: [Movie] = []
    
    init(_movies: [Movie]) {
        movies = _movies
    }
    
    
    var isEmpty: Bool {
        return movies.isEmpty
    }
    
    var moviesCount: Int {
        return movies.count
    }
    
    mutating func addMoreMovies(_ _movies: [Movie]) {
        movies += _movies
    }
}

extension MoviesViewModel {
    
    func movieAt(_ index: Int) -> Movie {
        guard !movies.isEmpty else {
            fatalError("No movie available")
        }
        return movies[index]
    }
    
    func posterURL(_ index: Int) -> URL? {
        guard !movies.isEmpty else {
            fatalError("No movie available")
        }
        
        guard let path = movies[index].poster_path, let url = URL(string: APIConstants.movieDBImagesBaseURL + path) else {
            return nil
        }
        
        return url
    }
}
