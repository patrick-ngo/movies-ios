//
//  MovieListCoordinator.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import UIKit
import CoreLocation

protocol MovieListCoordinatorInput: Coordinator {
  func goToMovieDetail()
}

final class MovieListCoordinator: MovieListCoordinatorInput {

  weak var parentCoordinator: Coordinator?

  var childCoordinators = [Coordinator]()

  private let navigationController: UINavigationController
  private let dependency: RootDependency

  init(navigationController: UINavigationController,
       dependency: RootDependency) {
    self.navigationController = navigationController
    self.dependency = dependency
  }

  func start() {
    let viewController = MovieListViewController()
    navigationController.viewControllers = [viewController]
  }

  func finish() {
    parentCoordinator?.childDidFinish(child: self)
    parentCoordinator?.finish()
  }

  func goToMovieDetail() {

  }
}
