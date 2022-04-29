//
//  GenresEnums.swift
//  movies-ios
//
//  Created by Patrick Ngo on 14/06/19.
//  Copyright © 2019 patrickngo. All rights reserved.
//


class MovieUtil {
  
  enum Genres {
    case action,
         adventure,
         animation,
         comedy,
         crime,
         documentary,
         family,
         fantasy,
         history,
         horror,
         music,
         mystery,
         romance,
         scienceFiction,
         tvMovie,
         thriller,
         war,
         western
    
    
    func id() -> Int {
      switch self {
      case .action:       return 28
      case .adventure:    return 12
      case .animation:    return 16
      case .comedy:       return 35
      case .crime:        return 80
      case .documentary:  return 99
      case .family:       return 10751
      case .fantasy:      return 14
      case .history:      return 36
      case .horror:       return 27
      case .music:        return 10402
      case .mystery:      return 9648
      case .romance:      return 10749
      case .scienceFiction:       return 878
      case .tvMovie:      return 10770
      case .thriller:     return 53
      case .war:          return 10752
      case .western:      return 37
      }
    }
    
    func name() -> String {
      switch self {
      case .action:       return "Action"
      case .adventure:    return "Adventure"
      case .animation:    return "Animation"
      case .comedy:       return "Comedy"
      case .crime:        return "Crime"
      case .documentary:  return "Documentary"
      case .family:       return "Family"
      case .fantasy:      return "Fantasy"
      case .history:      return "History"
      case .horror:       return "Horror"
      case .music:        return "Music"
      case .mystery:      return "Mystery"
      case .romance:      return "Romance"
      case .scienceFiction:       return "Science Fiction"
      case .tvMovie:      return "TV Movie"
      case .thriller:     return "Thriller"
      case .war:          return "War"
      case .western:      return "Western"
      }
    }
  }
  
  class func allGenres() -> [Genres] {
    
    return [Genres.action, Genres.adventure, Genres.animation,
            Genres.comedy, Genres.crime, Genres.documentary,
            Genres.family, Genres.fantasy, Genres.horror,
            Genres.music, Genres.mystery, Genres.romance,
            Genres.scienceFiction, Genres.tvMovie, Genres.thriller,
            Genres.war, Genres.western]
  }
  
}

