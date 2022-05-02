//
//  MockCoordinator.swift
//  movies-iosTests
//
//  Created by Patrick Ngo on 2022-05-02.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Foundation
import UIKit
@testable import movies_ios

class MockCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController = UINavigationController()

  var childDidFinishCalled = false
  func childDidFinish(child: Coordinator) {
    childDidFinishCalled = true
  }

  var startCalled = false
  func start() {
    startCalled = true
  }

  var finishCalled = false
  func finish() {
    finishCalled = true
  }
}
