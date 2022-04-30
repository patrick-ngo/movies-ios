//
//  MovieDetailIntent.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

protocol MovieDetailListener: AnyObject {}

protocol MovieDetailIntentInput {
  func bind<V: MovieDetailViewControllerInput>(to view: V)
  func goBack()
}

final class MovieDetailIntent: MovieDetailIntentInput {
  
  private enum Constants {
    static let firstPage = 1
    static let pageSize = 50
  }
  
  weak var coordinator: MovieDetailCoordinatorInput?
  private let movieService: MovieService
  private weak var listener: MovieDetailListener?
  
  private let stateDriver: StateDriver<MovieDetailState>
  private let disposeBag = DisposeBag()
  
  private var currentState: MovieDetailState {
    return stateDriver.value
  }
  
  init(movie: Movie,
       movieService: MovieService) {
    self.movieService = movieService
    stateDriver = StateDriver<MovieDetailState>(value: MovieDetailState(prevState: MovieDetailState.initialState,
                                                                        movie: movie))
  }
  
  func bind<V: MovieDetailViewControllerInput>(to view: V) {
    stateDriver.bind(to: view)
      .disposed(by: disposeBag)
  }
  
  func goBack() {
    coordinator?.finish()
  }
}
