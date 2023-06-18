//
//  MovieDetailViewSnapshotTests.swift //
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-09.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
@testable import movies_ios

class MovieDetailViewSnapshotTests: SnapshotTestCase {

  var sut: MovieDetailViewController!

  override func setUp() {
    super.setUp()
    sut = MovieDetailViewController()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testMovieDetailView_With_InitialState() {
    // when
    sut.update(with: .initialState,
               prevState: nil)

    // then
    verifyViewControllerWithTolerance(sut)
  }

  func testMovieDetailView_With_Details() {
    // when
    sut.update(with: MovieDetailState(prevState: .initialState,
                                      movie: nil,
                                      title: "test_title",
                                      posterPath: "test_poster_path",
                                      synopsys: "test_synopsis",
                                      genres: "test_genres",
                                      language: "test_language",
                                      runtime: "test_runtime"),
               prevState: .initialState)

    // then
    verifyViewControllerWithTolerance(sut)
  }
}
