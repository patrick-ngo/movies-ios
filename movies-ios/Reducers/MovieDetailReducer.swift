//
//  MovieDetailReducer.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift

struct MovieDetailState: Equatable {
  var selectedMovie: MovieModel?
}

func movieDetailReducer(action: Action, state: MovieDetailState?) -> MovieDetailState {
  // Create the default state if no state provided
  var state = state ?? MovieDetailState()
  
  switch action {
  case let action as SetSelectedMovie:
    state.selectedMovie = action.movie
    
  default:
    break
  }
  
  return state
}
