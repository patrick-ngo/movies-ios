//
//  MovieDetailState.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation

struct MovieDetailState: State {
  
  static let initialState = MovieDetailState(movie: nil)
  
  var movie: Movie? = nil
}

extension MovieDetailState {
  
  init(prevState: MovieDetailState,
       movie: Movie? = nil) {
    self.movie = movie ?? prevState.movie
  }
}
