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
  let movie: MovieModel
}

let fetchRelatedMovies = Thunk<AppState> { dispatch, getState in
  guard let state = getState()?.movieDetailState, let movieId = state.selectedMovie?.id else { return }
  
  MoviesAPI.shared.retrieveRelatedMovies(byId: movieId) { (result, error) in
    if let result = result, error == nil {
      do {
        let movieResponse = try JSONDecoder().decode(MovieModel.self, from: result)
        
        // TODO: Set related movies
      }
      catch let error {
        print("Error: \(error)")
      }
    }
  }
}
