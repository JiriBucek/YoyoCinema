//
//  MoviePreviewCell.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit
import Alamofire

class MoviePreviewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func getPosterImage(with url: String){
        if let url = URL(string: url){
            Alamofire.request(url).response { response in
                if let data = response.data {
                    if let image = UIImage(data: data){
                        self.movieImage.image = image
                    }
                } else {
                    print("Could not load the poster image.")
                }
            }
        }
    }
}
