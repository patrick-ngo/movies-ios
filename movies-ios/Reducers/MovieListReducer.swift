//
//  MovieListReducer.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift

struct MovieListState: Equatable {
    var hasNext = false
    var currentPage = 1
    var isFetchingMovies = false
    var movies: [MovieModel] = []
}

func movieListReducer(action: Action, state: MovieListState?) -> MovieListState {
    // Create the default state if no state provided
    var state = state ?? MovieListState()
    
    // Set the type of actions this reducer can receive
    guard let action = action as? MoviesStateAction else { return state }
    
    switch action {
    case .setIsFetchingMovies(let fetching):
        state.isFetchingMovies = fetching
        
    case .setMovies(let movies, let page, let hasNext):
        state.currentPage = page
        state.hasNext = hasNext
        state.movies = movies
        state.isFetchingMovies = false
        
    default:
        break
    }
    
    return state
}
