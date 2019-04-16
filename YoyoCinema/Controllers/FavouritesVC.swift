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
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
       tableView.reloadData()
        // For case of deleting a movie from favourites.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! FavouritesCell
        if let favourite = favouritesDataSource.favouriteForIndexPath(indexPath){
            cell.titleLabel.text = favourite.title
            if let imageUrl = favourite.imageUrl{
                cell.posterImageView.getPosterImage(with: imageUrl)
            }
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favouritesDataSource.numberOfFavourites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromFavourites" {
            let movieDetailVC = segue.destination as! MovieDetailVC
            guard let indexPath = tableView.indexPathForSelectedRow, let movieId = favouritesDataSource.favouriteForIndexPath(indexPath)?.id else {
                return
            }
            movieDetailVC.id = movieId
        }
    }
}
