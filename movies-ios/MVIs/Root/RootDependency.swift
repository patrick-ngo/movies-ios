//
//  RootDependency.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation

protocol RootDependency {
  var movieService: MovieService { get }
}

final class RootDependencyImp: RootDependency {
  let movieService: MovieService

  public init(movieService: MovieService) {
    self.movieService = movieService
  }
}
