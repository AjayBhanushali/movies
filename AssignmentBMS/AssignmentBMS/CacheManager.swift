//
//  CacheManager.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

class CacheManager {
    
    private let cache = NSCache<NSString, StructWrapper<Movie>>()
    private var keys = [Int]()
    
    static let shared = CacheManager()
    
    private init() {
        cache.countLimit = 5
    }
    
    func insert(movie: Movie) {
        if keys.contains(movie.id!) {
            return
        }
        
        if keys.count == 5 {
            removeMovie(for: keys.first!)
        }
        
        cache.setObject(StructWrapper(movie), forKey: movie.id!.description as NSString)
        keys.append(movie.id!) //insert(movie.id!)
    }
    
    func getMovie(for id: Int) -> Movie? {
        if let movie = cache.object(forKey: id.description as NSString) {
            print("The object is still cached")
            return movie.value
        } else {
            print("Web image went away")
            return nil
        }
    }
    
    func fetchAllMovies() -> [Movie]? {
        var movies: [Movie] = []
        guard !keys.isEmpty else {
            return nil
        }
        for key in keys.reversed() {
            if let movie = getMovie(for: key) {
                movies.append(movie)
            }
        }
        return movies
    }
    
    func removeMovie(for id: Int) {
        if let index = keys.firstIndex(of: id) {
            keys.remove(at: index)
        }
        cache.removeObject(forKey: id.description as NSString)
    }
}
