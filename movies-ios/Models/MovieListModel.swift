//
//  MovieListModel.swift
//  movies-ios
//
//  Created by Patrick Ngo on 11/11/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

//Movie List
struct MovieListModel:Decodable {
    let page: Int?
    let userId: Int?
    let name: Int?
    let results: [MovieModel]?
}


