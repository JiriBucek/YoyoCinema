//
//  SearchManager.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchManager: NSObject{
    
    private var movies = [Movie]()
    static let shared = SearchManager()
    
    
    // Public
    
    func requestSearchResults(with searchString: String, completionHandler: @escaping (_ success: Bool) -> Void ){
        let posterBasePath = "https://image.tmdb.org/t/p/w92"
        let searchBasePath = "https://api.themoviedb.org/3/search/movie?api_key=4cb1eeab94f45affe2536f2c684a5c9e&query="
        
        guard let url = URL(string: searchBasePath + self.removeSpecialCharacters(from: searchString)) else {
            completionHandler(false)
            return
        }
        
        guard !searchString.isEmpty else {
            movies.removeAll()
            completionHandler(true)
            return
        }
        
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value as Any)
                    
                    if let results = json["results"].array{
                        self.movies.removeAll()
                        for result in results{
                            let movie = Movie()
                            if let title = result["original_title"].string, let description = result["overview"].string, let posterPath = result["poster_path"].string, let year = result["release_date"].string, let id = result["id"].int{
                                
                                movie.title = title
                                movie.description = description
                                movie.releaseYear = year
                                movie.imageUrl = posterBasePath + posterPath
                                movie.id = id
                                self.movies.append(movie)
                            }
                            completionHandler(true)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }
        }
    }
    
    func movieForIndexPath(indexPath: IndexPath) -> Movie?{
        let row = indexPath.row
        if movies.count > row{
            return movies[row]
        }else{
            return nil
        }
    }
    
    func numberOfRows() -> Int{
        return movies.count
    }
    
    // Private
    
    private func removeSpecialCharacters( from oldString: String) -> String{
        var newString = oldString.replacingOccurrences(of: " ", with: "+")
        newString = newString.folding(options: .diacriticInsensitive, locale: .current)
        return newString
    }
}

