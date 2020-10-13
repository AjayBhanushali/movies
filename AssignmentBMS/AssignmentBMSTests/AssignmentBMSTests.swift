//
//  AssignmentBMSTests.swift
//  AssignmentBMSTests
//
//  Created by Ajay on 09/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import XCTest
@testable import AssignmentBMS

class SearchMoviesPresenterTests: XCTestCase {
    func testCaseOne() {
        let storedMovies = TestUtil().getMovies()
        let movies = SearchAlgorithm().shareMoviesThatStartsWith(searchString: "The", movies: storedMovies)
        //        XCTAssertEqual(movies.count, 1)
        XCTAssertTrue(movies.count > 0)
        XCTAssertEqual(movies.first?.title, "Mulan")
    }
    
    func testCaseTwo() {
        let storedMovies = TestUtil().getMovies()
        let movies = SearchAlgorithm().shareMoviesThatStartsWith(searchString: "Out the", movies: storedMovies)
        XCTAssertEqual(movies.first?.title, "The Outpost")
        XCTAssertTrue(movies.count > 0)
        
    }
}

class TestUtil {
    func getMovies() -> [Movie] {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Movies", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let moviesBase = try! JSONDecoder().decode(MoviesBase.self, from: data)
        return moviesBase.results ?? []
    }
}

