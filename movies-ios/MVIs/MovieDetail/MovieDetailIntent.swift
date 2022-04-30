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
  func getMovie()
}

final class MovieDetailIntent: MovieDetailIntentInput {
  
  private enum Constants {
    static let firstPage = 1
    static let pageSize = 50
  }
  
  weak var coordinator: MovieDetailCoordinatorInput?
  private let movieService: MovieService
  private let movie: Movie
  private weak var listener: MovieDetailListener?
  
  private let stateDriver: StateDriver<MovieDetailState>
  private let disposeBag = DisposeBag()
  private let locale = NSLocale(localeIdentifier: Locale.current.languageCode!)
  
  private var currentState: MovieDetailState {
    return stateDriver.value
  }
  
  init(movie: Movie,
       movieService: MovieService) {
    self.movieService = movieService
    self.movie = movie
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
  
  func getMovie() {  
    var genres = ""
    if let genreIds = movie.genre_ids,
                       genreIds.count > 0 {
      let genreNames = genreIds.map { (genreId) -> String in
        if let genre = MovieUtil.allGenres().first(where: { genreId == $0.id() }) {
          return genre.name()
        }
        return ""
      }
      genres = genreNames.joined(separator: " • ")
    }

    var language = ""
    if let original_language = movie.original_language {
      if let languageName = self.locale.displayName(forKey: NSLocale.Key.identifier, value: original_language) {
        language = "\(NSLocalizedString("LABEL_LANGUAGE", comment: "Language")) \(languageName)"
      }
    }
           
    var runtime = ""
    if let runtimeValue = movie.runtime {
      runtime = "\(NSLocalizedString("LABEL_RUNTIME", comment: "Runtime")) \(runtimeValue)m"
    }
    
    stateDriver.accept(MovieDetailState(prevState: currentState,
                                        title: movie.title,
                                        posterPath: movie.poster_path,
                                        synopsys: movie.overview,
                                        genres: genres,
                                        language: language,
                                        runtime: runtime))
  }
}
