//
//  MovieDetailIntentTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieDetailIntentTests: XCTestCase {
  
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

  var sut: MovieDetailIntent!
  var coordinator: MovieDetailMocks.CoordinatorMock!
  var view: MovieDetailMocks.ViewControllerMock!
  var movieService: MockMovieService!

  override func setUp() {
    super.setUp()
    coordinator = MovieDetailMocks.CoordinatorMock()
    view = MovieDetailMocks.ViewControllerMock()
    movieService = MockMovieService()
    sut = MovieDetailIntent(movie: Given.movie,
                            movieService: movieService)
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

  func testGoBack() {
    // given
    sut.bind(to: view)

    // when
    sut.goBack()

    // then
    XCTAssertTrue(coordinator.finishCalled)
  }

  func testGetMovie() {
    // given
    sut.bind(to: view)

    // when
    sut.getMovie()

    // then
    XCTAssertEqual(view.state?.title, "test_title")
    XCTAssertEqual(view.state?.synopsys, "test_overview")
  }
}
