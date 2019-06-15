//
//  MovieActions.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct SetSelectedMovie: Action {
    let movie: MovieModel
}

struct SetSelectedMovieId: Action {
    let movieId: Int
}

let fetchMovieDetail = Thunk<AppState> { dispatch, getState in
    guard let state = getState()?.movieDetailState, let movieId = state.selectedMovieId else { return }
    
    MoviesAPI.shared.retrieveMovie(byId: movieId) { (result, error) in
        if let result = result, error == nil {
            do {
                let movieResponse = try JSONDecoder().decode(MovieModel.self, from: result)
                
                // Set movie
                dispatch(SetSelectedMovie(movie: movieResponse))
            }
            catch let error {
                print("Error: \(error)")
            }
        }
    }
}
