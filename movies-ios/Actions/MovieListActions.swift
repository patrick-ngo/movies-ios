//
//  MovieListActions.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct SetStartFetchingMovies: Action {
  let isFetchingMovies: Bool
}

struct SetMovies: Action {
  let movies: [Movie]
  let page: Int
  let hasNext: Bool
}

func fetchMovies(_ reloadAll: Bool) -> Thunk<AppState> {
  return Thunk<AppState> { dispatch, getState in
    guard let state = getState()?.movieListState else { return }
    if state.isFetchingMovies {
      return
    }
    let page = reloadAll ? 1 : state.currentPage + 1
    var hasNext = false
    var movieList: [Movie] = []
    
    dispatch(SetStartFetchingMovies(isFetchingMovies: true))
    
    let movieService = MovieServiceImp()
    movieService.fetchNowPlayingMovies(for: page) { nowPlayingResult in
      switch nowPlayingResult {
      case .success(let moviesResponse):
        // Check if there are more movies to load
        if let totalPages = moviesResponse.total_pages {
          hasNext = page < totalPages
        }
        
        // Set list of movies
        if let movies = moviesResponse.results {
          movieList = reloadAll ? movies : state.movies + movies
        }
        
        dispatch(SetMovies(movies: movieList, page: page, hasNext: hasNext))
        
      case .failure(let error):
        print("Error: \(error)")
      }
    }
  }
}

