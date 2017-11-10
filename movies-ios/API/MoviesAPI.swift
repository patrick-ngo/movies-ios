//
//  MoviesAPI.swift
//  movies-ios
//
//  Created by Patrick Ngo on 11/10/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

import Alamofire



typealias JSONCompletionBlock = ( [String:Any]? ,_ error: Error?) -> Void
typealias DataCompletionBlock = ( Data? ,_ error: Error?) -> Void

class MoviesAPI
{
    static let API_KEY = "e4a3bc287b929e12897dd730b1b153e9"
    
    static let BASE_URL = "https://api.themoviedb.org/3/"
    
    static let BASE_URL_IMAGES_LOW = "https://image.tmdb.org/t/p/w185"
    static let BASE_URL_IMAGES_HIGH = "https://image.tmdb.org/t/p/w500"
    
    static let shared = MoviesAPI()
    
    //MARK: - API methods -
    
    //Retrieve movies
    func retrieveMovies(page: Int = 1, completionHandler: @escaping DataCompletionBlock) {
        
        let endPoint = "discover/movie"
        let url = URL(string: "\(MoviesAPI.BASE_URL)\(endPoint)")!
        
        
        let parameters: Parameters = ["page": page,
                                      "api_key": MoviesAPI.API_KEY,
                                      "sort_by": "release_date.desc",
                                      "primary_release_date.lte": "2016-12-31"]
        
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            
            completionHandler(response.data, response.error)
        }
    }
}

