//
//  MovieListState.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation

struct MovieListState: State {
  
  static let initialState = MovieListState(hasNext: false,
                                            page: 1,
                                            isLoading: false,
                                            movies: [])
  
  var hasNext = false
  var page = 0
  var isLoading = false
  var movies: [Movie] = []
}

extension MovieListState {
  
  init(prevState: MovieListState,
       hasNext: Bool? = nil,
       page: Int? = nil,
       isFetching: Bool? = nil,
       movies: [Movie]? = nil) {
    self.hasNext = hasNext ?? prevState.hasNext
    self.page = page ?? prevState.page
    self.isLoading = isFetching ?? prevState.isLoading
    self.movies = movies ?? prevState.movies
  }
}
