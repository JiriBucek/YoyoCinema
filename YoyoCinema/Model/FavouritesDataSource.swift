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
            let newFavourite = getCurrentMovie()
            guard !isAlreadyFavourite() else { return }
            
            var favouritesArray = [Favourite]()
            if let favouritesFromDefaults = loadFavourites(){
                favouritesArray = favouritesFromDefaults
            }
            favouritesArray.append(newFavourite)
        
            do{
                let data = try JSONEncoder().encode(favouritesArray)
                UserDefaults.standard.set(data, forKey: "Favourites")
            }catch{
                print("Error encoding favourites: \(error).")
                return
            }
    }
    
    func isAlreadyFavourite() -> Bool{
        let currentFavourite = getCurrentMovie()
        if let favouritesFromDefaults = loadFavourites() {
            return favouritesFromDefaults.contains(currentFavourite)
        }else{
            return false
        }
    }
    
    func deleteFromFavourites(){
        let currentMovie = getCurrentMovie()
        if var favouritesArray = loadFavourites(), isAlreadyFavourite(), let index = favouritesArray.firstIndex(of: currentMovie){
            favouritesArray.remove(at: index)
            
            do{
                let data = try JSONEncoder().encode(favouritesArray)
                UserDefaults.standard.set(data, forKey: "Favourites")
            }catch{
                print("Error encoding favourites: \(error).")
                return
            }
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
    
    func numberOfFavourites() -> Int{
        if let favouritesArray = loadFavourites(){
            return favouritesArray.count
        }else{
            return 0
        }
    }
    
    
    // Private
    
    private func loadFavourites() -> [Favourite]?{
         if let data = UserDefaults.standard.data(forKey: "Favourites"){
            do{
                let favouritesFromDefaults = try JSONDecoder().decode([Favourite].self, from: data)
                 return favouritesFromDefaults
            }catch{
                print("Error decoding fvourites.", error)
                return nil
            }
        }
        return nil
    }
    
    private func getCurrentMovie() -> Favourite{
        var favourite = Favourite()
        let movieDetail = detailAPI.movieDetail
        favourite.id = movieDetail.id
        favourite.title = movieDetail.title
        favourite.imageUrl = movieDetail.imageUrl
        return favourite
    }
}
