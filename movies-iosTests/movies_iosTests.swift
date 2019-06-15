//
//  movies_iosTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift
import XCTest

@testable import movies_ios

struct EmptyAction: Action { }

class movies_iosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialState() {
        let state = appReducer(action: EmptyAction(), state: nil)
        XCTAssertEqual(state, AppState())
    }
    
    func testStartFetchingMovies() {
        let action = SetStartFetchingMovies(isFetchingMovies: true)
        
        let state = appReducer(action: action, state: nil)
        
        guard state.movieListState.isFetchingMovies == true else {
            return XCTFail()
        }
    }
    
    func testSetSelectedMovieId() {
        let action = SetSelectedMovieId(movieId: 12345)
        
        let state = appReducer(action: action, state: nil)
        
        guard state.movieDetailState.selectedMovieId == 12345 else {
            return XCTFail()
        }
    }
    
    func testSetSelectedMovie() {
        let movie = MovieModel(vote_count: nil, id: 12345, vote_average: 2.7573, title: "Rambo", popularity: 1.563, poster_path: nil, original_language: "en", original_title: "Rambo", genres: nil, genre_ids: nil, backdrop_path: nil, adult: true, overview: "Rambo first blood", release_date: nil, runtime: 122)
        
        let action = SetSelectedMovie(movie: movie)
        
        let state = appReducer(action: action, state: nil)
        
        guard state.movieDetailState.selectedMovie == movie else {
            return XCTFail()
        }
    }
    
    func testSetMovies() {
        let movies = [
            MovieModel(vote_count: nil, id: 12345, vote_average: 2.7573, title: "Rambo", popularity: 1.563, poster_path: nil, original_language: "en", original_title: "Rambo", genres: nil, genre_ids: nil, backdrop_path: nil, adult: true, overview: "Rambo: First Blood", release_date: nil, runtime: 122),
            MovieModel(vote_count: nil, id: 12346, vote_average: 1.323, title: "Terminator", popularity: 3.123, poster_path: nil, original_language: "en", original_title: "Terminator", genres: nil, genre_ids: nil, backdrop_path: nil, adult: true, overview: "Terminator: Judgement Day", release_date: nil, runtime: 122)
        ]
        
        let action = SetMovies(movies: movies, page: 2, hasNext: true)
        
        let state = appReducer(action: action, state: nil)
        
        guard state.movieListState.movies == movies else {
            return XCTFail()
        }
        guard state.movieListState.currentPage == 2 else {
            return XCTFail()
        }
        guard state.movieListState.hasNext == true else {
            return XCTFail()
        }
    }
}
