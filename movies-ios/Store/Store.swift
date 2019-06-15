//
//  File.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-15.
//  Copyright © 2019 patrickngo. All rights reserved.
//
import ReSwift
import ReSwiftThunk

let thunksMiddleware: Middleware<MoviesState> = createThunksMiddleware()

let mainStore = Store(
    reducer: moviesReducer,
    state: MoviesState(),
    middleware: [thunksMiddleware]
)
