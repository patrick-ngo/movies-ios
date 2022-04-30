//
//  MovieDetailCoordinator.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import UIKit
import CoreLocation

protocol MovieDetailCoordinatorInput: Coordinator {}

final class MovieDetailCoordinator: MovieDetailCoordinatorInput {

  weak var parentCoordinator: Coordinator?
  var childCoordinators = [Coordinator]()

  private let navigationController: UINavigationController
  private let dependency: RootDependency
  private let movie: Movie

  init(navigationController: UINavigationController,
       dependency: RootDependency,
       movie: Movie) {
    self.navigationController = navigationController
    self.dependency = dependency
    self.movie = movie
  }

  func start() {
    let viewController = MovieDetailViewController()
    let intent = MovieDetailIntent(movie: movie,
                                   movieService: dependency.movieService)
    intent.coordinator = self
    viewController.intent = intent
    navigationController.pushViewController(viewController, animated: true)
  }

  func finish() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.childDidFinish(child: self)
  }
}
