//
//  MovieDetailReducer.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift

struct MovieDetailState: Equatable {
    var selectedMovie: MovieModel?
    var selectedMovieId: Int?
}

func movieDetailReducer(action: Action, state: MovieDetailState?) -> MovieDetailState {
    // Create the default state if no state provided
    var state = state ?? MovieDetailState()
    
    // Set the type of actions this reducer can receive
    guard let action = action as? MoviesStateAction else { return state }
    
    switch action {
    case .setSelectedMovieId(let movieId):
        state.selectedMovieId = movieId
        state.selectedMovie = nil
        
    case .setSelectedMovie(let movie):
        state.selectedMovie = movie
        
    default:
        break
    }
    
    return state
}
