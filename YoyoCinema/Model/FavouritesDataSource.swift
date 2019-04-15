//
//  Favourites.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation


class FavouritesDataSource{
    static let shared = FavouritesDataSource()
    
    let detailAPI = DetailAPI.shared
    
    func saveFavourite(){
        if let newFavourite = getCurrentFavourite(){
            guard isAlreadyFavourite(favourite: newFavourite) == false else {
                print("Already added")
                return }
            
            var favouritesArray = [Favourite]()
            if let favouritesFromDefaults = loadFavourites(){
                favouritesArray = favouritesFromDefaults
            }
            favouritesArray.append(newFavourite)
            let data = try! JSONEncoder().encode(favouritesArray)
            UserDefaults.standard.set(data, forKey: "Favourites")
        }
    }
    
    func loadFavourites() -> [Favourite]?{
         if let data = UserDefaults.standard.data(forKey: "Favourites"){
            do{
                let favouritesFromDefaults = try JSONDecoder().decode([Favourite].self, from: data)
                 return favouritesFromDefaults
            }catch{
                return nil
            }
        }
        return nil
    }
    
    func isAlreadyFavourite(favourite: Favourite) -> Bool{
        if let currentFavourite = getCurrentFavourite(), let favouritesFromDefaults = loadFavourites() {
            return favouritesFromDefaults.contains(currentFavourite)
        }else{
            return false
        }
    }
    
    
    func getCurrentFavourite() -> Favourite?{
        var currentFavourite = Favourite()
        if let movieDetail = detailAPI.movieDetail{
            currentFavourite.id = movieDetail.id
            currentFavourite.title = movieDetail.title
            currentFavourite.imageUrl = movieDetail.imageUrl
            return currentFavourite
        }else{
            return nil
        }
    }
    
}
