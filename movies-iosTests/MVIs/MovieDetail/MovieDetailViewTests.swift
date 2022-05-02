//
//  MovieDetailViewTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieDetailViewTests: XCTestCase {

  var sut: MovieDetailViewController!
  var intent: MovieDetailMocks.IntentMock!

  override func setUp() {
    super.setUp()
    sut = MovieDetailViewController()
    intent = MovieDetailMocks.IntentMock()
    sut.intent = intent
  }

  override func tearDown() {
    sut = nil
    intent = nil
    super.tearDown()
  }

  func testBackButtonTapped() {
    // when
    sut.onBackButtonTapped()

    // then
    XCTAssertTrue(intent.goBackCalled)
  }
  
  func testGetMovie() {
    // when
    sut.viewDidLoad()

    // then
    XCTAssertTrue(intent.getMovieCalled)
  }
}
