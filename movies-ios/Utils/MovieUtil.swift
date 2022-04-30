//
//  GenresEnums.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//

enum Genres: Int {
  case action = 28,
       adventure = 12,
       animation = 16,
       comedy = 35,
       crime = 80,
       documentary = 99,
       family = 10751,
       fantasy = 14,
       history = 36,
       horror = 27,
       music = 10402,
       mystery = 9648,
       romance = 10749,
       scienceFiction = 878,
       tvMovie = 10770,
       thriller = 53,
       war = 10752,
       western = 37
  
  var name: String {
    switch self {
    case .action:
      return "Action"
    case .adventure:
      return "Adventure"
    case .animation:
      return "Animation"
    case .comedy:
      return "Comedy"
    case .crime:
      return "Crime"
    case .documentary:
      return "Documentary"
    case .family:
      return "Family"
    case .fantasy:
      return "Fantasy"
    case .history:
      return "History"
    case .horror:
      return "Horror"
    case .music:
      return "Music"
    case .mystery:
      return "Mystery"
    case .romance:
      return "Romance"
    case .scienceFiction:
      return "Science Fiction"
    case .tvMovie:
      return "TV Movie"
    case .thriller:
      return "Thriller"
    case .war:
      return "War"
    case .western:
      return "Western"
    }
  }
  
  static var allGenres: [Genres] {
    return [Genres.action, Genres.adventure, Genres.animation,
            Genres.comedy, Genres.crime, Genres.documentary,
            Genres.family, Genres.fantasy, Genres.horror,
            Genres.music, Genres.mystery, Genres.romance,
            Genres.scienceFiction, Genres.tvMovie, Genres.thriller,
            Genres.war, Genres.western]
  }
}


