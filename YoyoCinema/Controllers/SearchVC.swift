//
//  ViewController.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var searchManager = SearchManager.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }


}


extension SearchVC: UITableViewDelegate{
    
    
}

extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewCell", for: indexPath) as! MoviePreviewCell
        
        if let movie = searchManager.movieForIndexPath(indexPath: indexPath){
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.description
            cell.getPosterImage(with: movie.imageUrl!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchManager.numberOfRows()
    }
}


extension SearchVC: UISearchBarDelegate, UITextFieldDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchManager.requestSearchResults(with: searchText){ success in
                self.searchTableView.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
}

