//
//  Favourite.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation

struct Favourite: Codable, Equatable{
    // Struc used for saving and loading list of user's favourite movies.
    
    var title: String?
    var imageUrl: String?
    var id: Int?
}
