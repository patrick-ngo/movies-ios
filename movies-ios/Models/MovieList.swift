//
//  MovieList.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

struct MovieList: Codable, Equatable {
  let page: Int?
  let results: [Movie]?
  let total_results: Int?
  let total_pages: Int?
}
