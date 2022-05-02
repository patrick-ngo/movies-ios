//
//  MovieDetailCoordinatorTests.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieDetailCoordinatorTests: XCTestCase {
  
  enum Given {
    static let movie = Movie(vote_count: nil,
                             id: 1234,
                             vote_average: nil,
                             title: nil,
                             popularity: nil,
                             poster_path: nil,
                             original_language: nil,
                             original_title: nil,
                             genres: nil,
                             genre_ids: nil,
                             backdrop_path: nil,
                             adult: nil,
                             overview: nil,
                             release_date: nil,
                             runtime: nil)
  }
  
  var sut: MovieDetailCoordinator!
  var navigationController: MockUINavigationController!
  var parentCoordinator: MockCoordinator!
  var dependency: MockRootDependency!
  
  override func setUp() {
    super.setUp()
    navigationController = MockUINavigationController()
    dependency = MockRootDependency()
    parentCoordinator = MockCoordinator()
    sut = MovieDetailCoordinator(navigationController: navigationController,
                                 dependency: dependency,
                                 movie: Given.movie)
    sut.parentCoordinator = parentCoordinator
  }
  
  override func tearDown() {
    sut = nil
    navigationController = nil
    parentCoordinator = nil
    super.tearDown()
  }
  
  func testStart() {
    // when
    sut.start()
    
    // then
    XCTAssertTrue(navigationController.pushViewController is MovieDetailViewController)
  }
  
  func testFinish() {
    // when
    sut.finish()
    
    // then
    XCTAssertTrue(parentCoordinator.childDidFinishCalled)
    XCTAssertTrue(navigationController.popCalled)
  }
}
