//
//  MovieDetailMocks.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
@testable import movies_ios

enum MovieDetailMocks {

  class IntentMock: MovieDetailIntentInput {

    var bindCalled = false
    func bind<V: MovieDetailViewControllerInput>(to view: V) {
      bindCalled = true
    }

    var goBackCalled = false
    func goBack() {
      goBackCalled = true
    }

    var getMovieCalled = false
    func getMovie() {
      getMovieCalled = true
    }
  }

  class ViewControllerMock: MovieDetailViewControllerInput {
    var state: MovieDetailState?
    var prevState: MovieDetailState?
    var updateCalled = false
    func update(with state: MovieDetailState, prevState: MovieDetailState?) {
      self.updateCalled = true
      self.state = state
      self.prevState = prevState
    }
  }

  class CoordinatorMock: MovieDetailCoordinatorInput {

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
  }
}
