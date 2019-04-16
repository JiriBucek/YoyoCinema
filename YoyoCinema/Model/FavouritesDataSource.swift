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
    
    // Public
    
    func savetoFavourites(){
        if let newFavourite = getCurrentMovie(){
            guard isAlreadyFavourite() == false else {
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
    
    func isAlreadyFavourite() -> Bool{
        if let currentFavourite = getCurrentMovie(), let favouritesFromDefaults = loadFavourites() {
            return favouritesFromDefaults.contains(currentFavourite)
        }else{
            return false
        }
    }
    
    func deleteFromFavourites(){
        if let currentMovie = getCurrentMovie(), var favouritesArray = loadFavourites(), isAlreadyFavourite(), let index = favouritesArray.firstIndex(of: currentMovie){
            favouritesArray.remove(at: index)
            let data = try! JSONEncoder().encode(favouritesArray)
            UserDefaults.standard.set(data, forKey: "Favourites")
        }else{
            return
        }
    }
    
    func favouriteForIndexPath(_ indexPath: IndexPath) -> Favourite?{
        if let favouritesArray = loadFavourites(){
            return favouritesArray[indexPath.row]
        }else{
            return nil
        }
    }
    
    func numberOfFavourites() -> Int?{
        if let favouritesArray = loadFavourites(){
            return favouritesArray.count
        }else{
            return nil
        }
    }
    
    
    // Private
    
    private func loadFavourites() -> [Favourite]?{
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
    
    private func getCurrentMovie() -> Favourite?{
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
