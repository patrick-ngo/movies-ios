//
//  Movie.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

struct Movie: Codable, Equatable {
  let vote_count: Int?
  let id: Int?
  let vote_average: Double?
  let title: String?
  let popularity: Double?
  let poster_path: String?
  let original_language: String?
  let original_title: String?
  let genres: [Genre]?
  let genre_ids: [Int]?
  let backdrop_path: String?
  let adult: Bool?
  let overview: String?
  let release_date: String?
  let runtime: Int?
}
