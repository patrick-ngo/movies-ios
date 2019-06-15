//
//  MovieActions.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//


import ReSwift
import ReSwiftThunk

// all of the actions that can be applied to the state
enum MoviesStateAction: Action {
    case setSelectedMovieId(Int)
    
    case setSelectedMovie(MovieModel)
    
    case setIsFetchingMovies(Bool)
    case setMovies([MovieModel], Int, Bool)
}

func fetchMovies(_ reloadAll: Bool) -> Thunk<MoviesState> {
    return Thunk<MoviesState> { dispatch, getState in
        guard let state = getState() else { return }
        if state.isFetchingMovies {
            return
        }
        let page = reloadAll ? 1 : state.currentPage + 1
        var hasNext = false
        var movieList: [MovieModel] = []
        
        dispatch(MoviesStateAction.setIsFetchingMovies(true))
        
        MoviesAPI.shared.retrieveMovies(page: page) { (result, error) in
            if let result = result, error == nil {
                do {
                    let moviesResponse = try JSONDecoder().decode(MovieListModel.self, from: result)
                    
                    // Check if there are more movies to load
                    if let totalPages = moviesResponse.total_pages {
                        hasNext = page < totalPages
                    }
                    
                    // Set list of movies
                    if let movies = moviesResponse.results {
                        movieList = reloadAll ? movies : state.movies + movies
                    }

                    dispatch(MoviesStateAction.setMovies(movieList, page, hasNext))
                }
                catch let error {
                    print("Error: \(error)")
                }
            }
        }
    }
}



let fetchMovieDetail = Thunk<MoviesState> { dispatch, getState in
    guard let state = getState(), let movieId = state.selectedMovieId else { return }
    
    MoviesAPI.shared.retrieveMovie(byId: movieId) { (result, error) in
        if let result = result, error == nil {
            do {
                let movieResponse = try JSONDecoder().decode(MovieModel.self, from: result)
                
                // Set movie
                dispatch(MoviesStateAction.setSelectedMovie(movieResponse))
            }
            catch let error {
                print("Error: \(error)")
            }
        }
    }
}
