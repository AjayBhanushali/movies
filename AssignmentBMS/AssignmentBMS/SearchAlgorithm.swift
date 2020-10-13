//
//  SearchAlgorithm.swift
//  AssignmentBMS
//
//  Created by Ajay on 11/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import Foundation

class SearchAlgorithm {
    
    /// Searches for the strings based on weightage
    /// - Parameters:
    ///   - searchString: search string
    ///   - movies: in the list
    /// - Returns: search result
    func shareMoviesThatStartsWith(searchString: String, movies: [Movie]) -> [Movie] {
        
        let splitedMovies = movies.map({$0.title.lowercased().split(separator: " ").sorted()})
        
        // This keeps the weighted in the value
        var resultMovies: [Movie: Int] = [:]
        
        let searchStrings = searchString.lowercased().split(separator: " ") // O(n)
        
        for i in 0..<splitedMovies.count {
            for slicedSearchString in searchStrings {
                if startsWithUsingBinarySearch(searchString: slicedSearchString, array: splitedMovies[i]) {
                    print(slicedSearchString)
                    // increasing weightage by 1
                    resultMovies[movies[i]] = (resultMovies[movies[i]] ??  0) + 1
                }
            }
        }
        
        print(resultMovies)
        let weightedBasedMovies = resultMovies.sorted { $0.1 > $1.1 } // O(n^2)
        return weightedBasedMovies.map({$0.key}) // O(n)
    }
    
    /// tell if search string starts with using binary search
    /// - Parameters:
    ///   - searchString: search text
    ///   - array: in the list
    /// - Returns: return bool
    private func startsWithUsingBinarySearch(searchString: String.SubSequence, array: [String.SubSequence]) -> Bool {
            var lowerBound = 0
            var upperBound = array.count - 1
            var middle = 0
            var found = false

            while(lowerBound <= upperBound) {
                
                // find the middle of the array
                middle = (lowerBound + upperBound) / 2
                
                if(array[middle].hasPrefix(searchString)) {
                    found = true
                    break
                } else if(array[middle] < searchString) {
                    lowerBound = middle + 1
                } else {
                    upperBound = middle - 1
                }
            }
            
            return found
        }
}
