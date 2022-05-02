//
//  MockMovieService.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation
@testable import movies_ios

final class MockMovieService: MovieService {
  
  var fetchNowPlayingMoviesResponse = NowPlayingMoviesResponse(page: 1,
                                                               results: [],
                                                               total_results: 0,
                                                               total_pages: 1)
  var fetchNowPlayingMoviesCalled = false
  func fetchNowPlayingMovies(for page: Int,
                             completion: @escaping (Result<NowPlayingMoviesResponse, Error>) -> Void) {
    fetchNowPlayingMoviesCalled = true
    completion(.success(fetchNowPlayingMoviesResponse))
  }
  
  
  var fetchRelatedMoviesResponse = RelatedMoviesResponse(page: 1,
                                                         results: [],
                                                         total_results: 0,
                                                         total_pages: 1)
  var fetchRelatedMoviesCalled = false
  func fetchRelatedMovies(for movieId: Int,
                          completion: @escaping (Result<RelatedMoviesResponse, Error>) -> Void) {
    fetchRelatedMoviesCalled = true
    completion(.success(fetchRelatedMoviesResponse))
  }
}
