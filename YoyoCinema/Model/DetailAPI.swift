//
//  DetailAPI.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class DetailAPI{
    
    static let shared = DetailAPI()
    var movieDetail: Movie
    
    private init(){
        self.movieDetail = Movie()
    }
    
    func requestMovieDetails(for movieId: Int, completionHandler: @escaping (_ success: Bool) -> Void){
        let posterImageBasePath = "https://image.tmdb.org/t/p/w200"
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=4cb1eeab94f45affe2536f2c684a5c9e") else {
            completionHandler(false)
            return
        }
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    self.movieDetail = Movie()
                    let json = JSON(response.result.value as Any)

                    if let title = json["title"].string{
                        var year = ""
                        if var date = json["release_date"].string, date.count > 4{
                            date = String(date.prefix(4))
                            year = " (\(date))"
                        }
                        self.movieDetail.title = title + year
                    }
                    
                    if let id = json["id"].int{
                        self.movieDetail.id = id
                    }
                    
                    if let description = json["overview"].string{
                        self.movieDetail.description = description
                    }
                    
                    if let original = json["original_title"].string{
                        self.movieDetail.originalTitle = original
                    }
                    
                    if let imageUrl = json["poster_path"].string{
                        self.movieDetail.imageUrl = posterImageBasePath + imageUrl
                    }
                    
                    if let lenght = json["runtime"].int{
                        self.movieDetail.length = lenght
                    }
                    
                    if let rank = json["vote_average"].double{
                        self.movieDetail.rank = rank
                    }
                    
                    if let genres = json["genres"].array, genres.count > 0{
                        var genresArray = [String]()
                        for genre in genres{
                            if let name = genre["name"].string{
                                genresArray.append(name)
                            }
                        }
                        self.movieDetail.genres = genresArray
                    }
                    completionHandler(true)
                
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }
        }
    }
}
