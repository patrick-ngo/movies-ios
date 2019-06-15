//
//  MovieListModel.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

//Movie List
struct MovieListModel: Codable, Equatable {
    let page: Int?
    let userId: Int?
    let name: Int?
    let results: [MovieModel]?
    let total_results: Int?
    let total_pages: Int?
}


