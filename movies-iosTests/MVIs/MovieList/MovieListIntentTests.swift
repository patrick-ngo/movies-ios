//
//  MovieListIntentTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieListIntentTests: XCTestCase {
  
  enum Given {
    static let movie = Movie(vote_count: nil,
                             id: 1234,
                             vote_average: nil,
                             title: "test_title",
                             popularity: nil,
                             poster_path: nil,
                             original_language: nil,
                             original_title: nil,
                             genres: nil,
                             genre_ids: nil,
                             backdrop_path: nil,
                             adult: nil,
                             overview: "test_overview",
                             release_date: nil,
                             runtime: nil)
  }

  var sut: MovieListIntent!
  var coordinator: MovieListMocks.CoordinatorMock!
  var view: MovieListMocks.ViewControllerMock!
  var movieService: MockMovieService!

  override func setUp() {
    super.setUp()
    coordinator = MovieListMocks.CoordinatorMock()
    view = MovieListMocks.ViewControllerMock()
    movieService = MockMovieService()
    sut = MovieListIntent(contributionService: movieService)
    sut.coordinator = coordinator
  }

  override func tearDown() {
    sut = nil
    coordinator = nil
    view = nil
    movieService = nil
    super.tearDown()
  }

  func testUpdate() {
    // when
    sut.bind(to: view)

    // then
    XCTAssertTrue(view.updateCalled)
  }

  func testGetMovies() {
    // given
    sut.bind(to: view)

    // when
    sut.getMovies()

    // then
    XCTAssertTrue(movieService.fetchNowPlayingMoviesCalled)
  }
  
  func testGetMoreMovies() {
    // given
    sut.bind(to: view)

    // when
    sut.getMoreMovies()

    // then
    XCTAssertTrue(movieService.fetchNowPlayingMoviesCalled)
  }
  
  func testGoToMovieDetail() {
//    // given
//    sut.bind(to: view)
//
//    // when
//    sut.goToMovieDetail(with: 0)
//
//    // then
//    XCTAssertTrue(coordinator.goToMovieDetailCalled)
  }
}
