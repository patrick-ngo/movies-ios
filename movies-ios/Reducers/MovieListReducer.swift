//
//  MovieListReducer.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift

struct MovieListState: Equatable {
  var hasNext = false
  var currentPage = 0
  var isFetchingMovies = false
  var movies: [MovieModel] = []
}

func movieListReducer(action: Action, state: MovieListState?) -> MovieListState {
  // Create the default state if no state provided
  var state = state ?? MovieListState()
  
  switch action {
    
  case let action as SetStartFetchingMovies:
    state.isFetchingMovies = action.isFetchingMovies
    
  case let action as SetMovies:
    state.currentPage = action.page
    state.hasNext = action.hasNext
    state.movies = action.movies
    state.isFetchingMovies = false
    
  default:
    break
  }
  
  return state
}
