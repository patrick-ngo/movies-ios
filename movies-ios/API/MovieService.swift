//
//  MovieService.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import Alamofire

protocol MovieService {
  func fetchNowPlayingMovies(for page: Int,
                             completion: @escaping (Swift.Result<NowPlayingMoviesResponse, Error>) -> Void)
  func fetchRelatedMovies(for movieId: Int,
                          completion: @escaping (Swift.Result<RelatedMoviesResponse, Error>) -> Void)
}

final class MovieServiceImp: MovieService {
  
  private enum Constants {
    static let API_KEY = "e4a3bc287b929e12897dd730b1b153e9"
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
    static let CATHAY_URL = "https://www.cathaycineplexes.com.sg/"
  }

  init() {}
  
  func fetchNowPlayingMovies(for page: Int,
                             completion: @escaping (Swift.Result<NowPlayingMoviesResponse, Error>) -> Void) {
    let endPoint = "movie/now_playing"
    let url = URL(string: "\(Constants.BASE_URL)\(endPoint)")!
    let parameters: Parameters = ["page": page,
                                  "api_key": Constants.API_KEY]
    
    Alamofire.request(url, parameters: parameters).response { response in
      if let result = response.data,
         let moviesResponse = try? JSONDecoder().decode(NowPlayingMoviesResponse.self, from: result) {

        completion(.success(moviesResponse))
      } else if let error = response.error {

        completion(.failure(error))
      }
    }
  }

  func fetchRelatedMovies(for movieId: Int,
                          completion: @escaping (Swift.Result<RelatedMoviesResponse, Error>) -> Void) {
    let endPoint = "movie/\(movieId)/similar"
    let url = URL(string: "\(Constants.BASE_URL)\(endPoint)")!
    let parameters: Parameters = ["api_key": Constants.API_KEY]
    
    Alamofire.request(url, parameters: parameters).response { response in
      if let result = response.data,
         let moviesResponse = try? JSONDecoder().decode(RelatedMoviesResponse.self, from: result) {

        completion(.success(moviesResponse))
      } else if let error = response.error {

        completion(.failure(error))
      }
    }
  }
}

typealias NowPlayingMoviesResponse = MovieList
typealias RelatedMoviesResponse = MovieList
