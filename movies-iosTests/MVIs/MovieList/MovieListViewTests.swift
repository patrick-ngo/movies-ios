//
//  MovieListViewTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieListViewTests: XCTestCase {

  var sut: MovieListViewController!
  var intent: MovieListMocks.IntentMock!

  override func setUp() {
    super.setUp()
    sut = MovieListViewController()
    intent = MovieListMocks.IntentMock()
    sut.intent = intent
  }

  override func tearDown() {
    sut = nil
    intent = nil
    super.tearDown()
  }
  
  func testViewDidLoad() {
    // when
    sut.viewDidLoad()

    // then
    XCTAssertTrue(intent.getMoviesCalled)
  }
  
  func testOnRefreshPulled() {
    // when
    sut.onRefreshPulled()

    // then
    XCTAssertTrue(intent.getMoviesCalled)
  }
  
  func testOnEndOfListReached() {
    // when
    sut.onEndOfListReached()

    // then
    XCTAssertTrue(intent.getMoreMoviesCalled)
  }
  
  func testOnMovieCellTapped() {
    // when
    sut.onMovieCellTapped(with: 0)

    // then
    XCTAssertTrue(intent.goToMovieDetailCalled)
  }
}
