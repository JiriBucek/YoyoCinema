//
//  MoviePreviewCell.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit

class MoviePreviewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
