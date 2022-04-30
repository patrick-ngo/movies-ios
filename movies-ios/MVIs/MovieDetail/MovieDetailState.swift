//
//  MovieDetailState.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation

struct MovieDetailState: State {
  
  static let initialState = MovieDetailState(movie: nil,
                                             title: "",
                                             synopsys: "",
                                             genres: "",
                                             language: "",
                                             runtime: "")
  
  var movie: Movie? = nil
  var title: String = ""
  var posterPath: String = ""
  var synopsys: String = ""
  var genres: String = ""
  var language: String = ""
  var runtime: String = ""
}

extension MovieDetailState {
  
  init(prevState: MovieDetailState,
       movie: Movie? = nil,
       title: String? = nil,
       posterPath: String? = nil,
       synopsys: String? = nil,
       genres: String? = nil,
       language: String? = nil,
       runtime: String? = nil) {
    self.movie = movie ?? prevState.movie
    self.title = title ?? prevState.title
    self.posterPath = posterPath ?? prevState.posterPath
    self.synopsys = synopsys ?? prevState.synopsys
    self.genres = genres ?? prevState.genres
    self.language = language ?? prevState.language
    self.runtime = runtime ?? prevState.runtime
  }
}
