//
//  RootCoordinator.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import UIKit
import CoreLocation

protocol RootCoordinatorInput: Coordinator {}

final class RootCoordinator: Coordinator,
                             RootCoordinatorInput {

  var childCoordinators = [Coordinator]()
  var keyWindow: UIWindow?

  var rootNavigationController: UINavigationController = {
    let navigationController = UINavigationController(rootViewController: RootViewController())
    navigationController.setNavigationBarHidden(false, animated: false)
    navigationController.modalPresentationStyle = .overFullScreen
    return navigationController
  }()

  let dependency: RootDependency

  init(keyWindow: UIWindow) {
    self.keyWindow = keyWindow
    let movieService = MovieServiceImp()
    dependency = RootDependencyImp(movieService: movieService)
  }

  func start() {
    let navigationController = UINavigationController()
    navigationController.setNavigationBarHidden(true, animated: false)
    navigationController.modalPresentationStyle = .overFullScreen
    keyWindow?.rootViewController = navigationController
    let windowLevel = (UIApplication.shared.currentWindow?.windowLevel ?? .normal) + 1
    keyWindow?.windowLevel = windowLevel
    keyWindow?.makeKeyAndVisible()
    

    
    navigationController.present(rootNavigationController, animated: false) {}
    attachMovieList()
  }

  func finish() {
    _ = rootNavigationController.popViewController(animated: false)
    self.keyWindow = nil
  }

  private func attachMovieList() {
    let movieListCoordinator = MovieListCoordinator(navigationController: rootNavigationController,
                                                   dependency: dependency)
    movieListCoordinator.parentCoordinator = self
    movieListCoordinator.start()
    childCoordinators.append(movieListCoordinator)
  }
}

private class RootViewController: UIViewController {}
