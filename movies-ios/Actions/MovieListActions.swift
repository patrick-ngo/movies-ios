//
//  MovieListActions.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct SetStartFetchingMovies: Action {
    let isFetchingMovies: Bool
}

struct SetMovies: Action {
    let movies: [MovieModel]
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
        var movieList: [MovieModel] = []
        
        dispatch(SetStartFetchingMovies(isFetchingMovies: true))
        
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
                    
                    dispatch(SetMovies(movies: movieList, page: page, hasNext: hasNext))
                }
                catch let error {
                    print("Error: \(error)")
                }
            }
        }
    }
}

