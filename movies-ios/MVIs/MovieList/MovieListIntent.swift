//
//  MovieListIntent.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa

protocol MovieListListener: AnyObject {}

protocol MovieListIntentInput {
  func bind<V: MovieListViewControllerInput>(to view: V)
  func getMovies()
  func getMoreMovies()
  func goToMovieDetail(with index: Int)
}

final class MovieListIntent: MovieListIntentInput {
  
  private enum Constants {
    static let firstPage = 1
    static let pageSize = 50
  }
  
  weak var coordinator: MovieListCoordinatorInput?
  private let movieService: MovieService
  private weak var listener: MovieListListener?
  
  private let stateDriver: StateDriver<MovieListState>
  private let disposeBag = DisposeBag()
  
  private var currentState: MovieListState {
    return stateDriver.value
  }
  
  init(contributionService: MovieService) {
    self.movieService = contributionService
    stateDriver = StateDriver<MovieListState>(value: MovieListState(prevState: MovieListState.initialState))
  }
  
  func bind<V: MovieListViewControllerInput>(to view: V) {
    stateDriver.bind(to: view)
      .disposed(by: disposeBag)
  }
  
  func goToMovieDetail(with index: Int) {
    let selectedMovie = currentState.movies[index]
    coordinator?.goToMovieDetail(with: selectedMovie)
  }
  
  func getMovies() {
    fetchNowPlayingMovies(for: Constants.firstPage)
  }
  
  func getMoreMovies() {
    let nextPage = currentState.page + Constants.firstPage
    fetchNowPlayingMovies(for: nextPage)
  }
  
  private func fetchNowPlayingMovies(for page: Int) {
    stateDriver.accept(MovieListState(prevState: currentState,
                                      isFetching: true))
    
    movieService.fetchNowPlayingMovies(for: page) { [weak self] nowPlayingMoviesResult in
      guard let this = self else { return }
      switch nowPlayingMoviesResult {
      case .success(let nowPlayingMoviesResponse):
        if let movies = nowPlayingMoviesResponse.results,
           let totalCount = nowPlayingMoviesResponse.total_results,
           let currentPage = nowPlayingMoviesResponse.page {
          let hasNext = this.calculateHasNext(with: totalCount, currentPage: currentPage)
          let updatedMovies = currentPage == Constants.firstPage ? movies : this.currentState.movies + movies

          let movieViewModels = movies.map { movie -> MovieListCellViewModel in
            var genres: String?
            if let genreIds = movie.genre_ids,
               genreIds.count > 0 {
              // Match genre ids with genre names
              let genreNames = genreIds.map { Genres(rawValue: $0)?.name ?? "" }
              genres = genreNames.joined(separator: " • ")
            }
            
            var popularity: String?
            if let popularityValue = movie.popularity,
               popularityValue > 0 {
              popularity = String(popularityValue)
            }
            return MovieListCellViewModel(title: movie.title,
                                          genres: genres,
                                          posterUrl: movie.poster_path,
                                          popularity: popularity)
          }
          

          let updatedMovieViewModels = currentPage == Constants.firstPage ? movieViewModels : this.currentState.movieViewModels + movieViewModels
          this.stateDriver.accept(MovieListState(prevState: this.currentState,
                                                 hasNext: hasNext,
                                                 isFetching: false,
                                                 movies: updatedMovies,
                                                 movieViewModels: updatedMovieViewModels))
        }
      case .failure:
        this.stateDriver.accept(MovieListState(prevState: this.currentState,
                                               isFetching: false))
      }
    }
  }
  
  private func calculateHasNext(with totalCount: Int,
                                currentPage: Int) -> Bool {
    let totalPageCount = Int((Double(totalCount) / Double(Constants.pageSize)).rounded(.up))
    let hasNext = (totalPageCount - currentPage) > 0
    return hasNext
  }
}
