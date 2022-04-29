//
//  MovieActions.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct SetSelectedMovie: Action {
  let movie: Movie
}

let fetchRelatedMovies = Thunk<AppState> { dispatch, getState in
  guard let state = getState()?.movieDetailState, let movieId = state.selectedMovie?.id else { return }
  
  let movieService = MovieServiceImp()
  movieService.fetchRelatedMovies(for: movieId) { relatedMoviesResult in
    switch relatedMoviesResult {
    case .success(let response):
      break // TODO: Set related movies
      
    case .failure(let error):
      print("Error: \(error)")
    }
  }
}
