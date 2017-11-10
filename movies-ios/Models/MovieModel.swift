//
//  MovieModel.swift
//  movies-ios
//
//  Created by Charmaine on 11/11/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

//Movie
struct MovieModel:Decodable {
    let vote_count: Int?
    let id: Int?
    let vote_average: Double?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
}

