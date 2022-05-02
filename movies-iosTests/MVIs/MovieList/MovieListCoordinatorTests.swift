//
//  MovieListCoordinator.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import movies_ios

class MovieListCoordinatorTests: XCTestCase {
  
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
  
  var sut: MovieListCoordinator!
  var navigationController: MockUINavigationController!
  var parentCoordinator: MockCoordinator!
  var dependency: MockRootDependency!
  
  override func setUp() {
    super.setUp()
    navigationController = MockUINavigationController()
    dependency = MockRootDependency()
    parentCoordinator = MockCoordinator()
    sut = MovieListCoordinator(navigationController: navigationController,
                                 dependency: dependency)
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
    XCTAssertTrue(navigationController.topViewController is MovieListViewController)
  }
  
  func testFinish() {
    // when
    sut.finish()
    
    // then
    XCTAssertTrue(parentCoordinator.childDidFinishCalled)
    XCTAssertTrue(parentCoordinator.finishCalled)
  }
  
  func testGoToMovieDetail() {
    // given
    let initialNumChildCoordinators = sut.childCoordinators.count

    // when
    sut.goToMovieDetail(with: Given.movie)
    
    // then
    XCTAssertEqual(sut.childCoordinators.count, initialNumChildCoordinators + 1)
    XCTAssertTrue(sut.childCoordinators.first is MovieDetailCoordinator)
    XCTAssertTrue(navigationController.pushViewController is MovieDetailViewController)
  }
}

