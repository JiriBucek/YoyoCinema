//
//  FavouritesVC.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit

class FavouritesVC: UITableViewController {
    
    let favouritesDataSource = FavouritesDataSource.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavouritesCell
        if let favourite = favouritesDataSource.favouriteForIndexPath(indexPath){
            cell.titleLabel.text = favourite.title
            cell.posterImageView.getPosterImage(with: favourite.imageUrl!)
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let favouritesNumber = favouritesDataSource.numberOfFavourites(){
            return favouritesNumber
        }else{
            return 0
        }
    }



}
