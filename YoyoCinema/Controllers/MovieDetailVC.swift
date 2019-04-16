//
//  MovieDetailVC.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit

class MovieDetailVC: UITableViewController {
    
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var lengthLabel: UILabel!
    
    @IBOutlet weak var originalTitleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    @IBOutlet weak var movieRankLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    @IBAction func addToFavouritesButtonPressed(_ sender: Any) {
        if favouritesDataSource.isAlreadyFavourite(){
            favouritesDataSource.deleteFromFavourites()
        }else{
            favouritesDataSource.savetoFavourites()
        }
        toggleFavouritesButton()
    }
    
    var id: Int?
    let detailAPI = DetailAPI.shared
    let favouritesDataSource = FavouritesDataSource.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        ActivityIndicator.shared.startAnimating(view: self.view)
        loadDetails()
    }
    

    func loadDetails(){
        if let id = id{
            detailAPI.requestMovieDetails(for: id) { success in
                if success{
                    if let movieDetail = self.detailAPI.movieDetail{
                        var movieTitle = ""
                        if let title = movieDetail.title{
                            movieTitle = title
                            if let year = movieDetail.releaseYear{
                                movieTitle += " (\(year))"
                            }
                        }
                        self.movieTitleLabel.text = movieTitle
                        
                        self.movieDescriptionLabel.text = movieDetail.description
                        
                        if let rank = movieDetail.rank{
                            self.movieRankLabel.text = "\(rank) / 10"
                            self.movieRankLabel.textColor = self.setRankColor(for: rank)
                        }
                        
                        if let imageUrl = movieDetail.imageUrl{
                            self.moviePosterImage.getPosterImage(with: imageUrl)
                        }
                        
                        if let length = movieDetail.length{
                            self.lengthLabel.text = "\(length) min"
                        }
                        
                        if let originalTitle = movieDetail.originalTitle{
                            self.originalTitleLabel.text = originalTitle
                        }
                        
                        if let genres = movieDetail.genres{
                            var genresString = ""
                            for genre in genres { genresString += "\(genre) "}
                            self.genreLabel.text = genresString
                        }
                        self.toggleFavouritesButton()
                        self.tableView.reloadData()
                        ActivityIndicator.shared.stopAnimating()
                    }
                }else{
                    self.displayAlert(userMessage: "Could not load data. Please try again later.")
                }
            }
        }
    }
    
    func toggleFavouritesButton(){
        if favouritesDataSource.isAlreadyFavourite(){
                addToFavouritesButton.setTitle("Remove from favourites", for: .normal)
                addToFavouritesButton.setTitleColor(UIColor.myColors.red, for: .normal)
            }else{
                addToFavouritesButton.setTitle("Add to favourites", for: .normal)
            addToFavouritesButton.setTitleColor(UIColor.myColors.blue, for: .normal)
            }
    }
    
    func setRankColor(for rank: Double) -> UIColor{
        switch rank{
        case 0...3:
            return UIColor.myColors.red
        case 3...6:
            return UIColor.myColors.yellow
        default:
            return UIColor.myColors.green
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }

    
}
