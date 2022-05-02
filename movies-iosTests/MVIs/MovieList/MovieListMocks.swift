//
//  MovieListMocks.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
@testable import movies_ios

enum MovieListMocks {

  class IntentMock: MovieListIntentInput {
    
    var bindCalled = false
    func bind<V: MovieListViewControllerInput>(to view: V) {
      bindCalled = true
    }

    var getMoviesCalled = false
    func getMovies() {
      getMoviesCalled = true
    }

    var getMoreMoviesCalled = false
    func getMoreMovies() {
      getMoreMoviesCalled = true
    }

    var goToMovieDetailCalled = false
    func goToMovieDetail(with index: Int) {
      goToMovieDetailCalled = true
    }
  }

  class ViewControllerMock: MovieListViewControllerInput {
    var state: MovieListState?
    var prevState: MovieListState?
    var updateCalled = false
    func update(with state: MovieListState, prevState: MovieListState?) {
      self.updateCalled = true
      self.state = state
      self.prevState = prevState
    }
  }

  class CoordinatorMock: MovieListCoordinatorInput {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    var startCalled = false
    func start() {
      startCalled = true
    }

    var finishCalled = false
    func finish() {
      finishCalled = true
    }

    var goToMovieDetailCalled = false
    func goToMovieDetail(with movie: Movie) {
      goToMovieDetailCalled = true
    }    
  }
}
