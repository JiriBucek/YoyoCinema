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
    
    var searchAPI = SearchAPI.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBar.delegate = self
    }
}


extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailSegue" {
            let movieDetailVC = segue.destination as! MovieDetailVC
            guard let indexPath = searchTableView.indexPathForSelectedRow, let movieId = searchAPI.movieForIndexPath(indexPath: indexPath)?.id else {
                return
            }
            movieDetailVC.id = movieId
        }
    }
    
    
}

extension SearchVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewCell", for: indexPath) as! MoviePreviewCell
        
        if let movie = searchAPI.movieForIndexPath(indexPath: indexPath){
            var titleText = ""
            if let title = movie.title{
                titleText = title
                if let year = movie.releaseYear{
                    titleText += " (\(year))"
                }
            }
            cell.titleLabel.text = titleText
            
            cell.descriptionLabel.text = movie.description
            
            if let imageUrl = movie.imageUrl{
                cell.movieImage.getPosterImage(with: imageUrl)
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAPI.numberOfRows()
    }
}


extension SearchVC: UISearchBarDelegate, UITextFieldDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTableView.isHidden = true
        ActivityIndicator.shared.startAnimating(view: backgroundView)
        
            searchAPI.requestSearchResults(with: searchText){ success in
                self.searchTableView.reloadData()
                ActivityIndicator.shared.stopAnimating()
                self.searchTableView.isHidden = false
                
                if self.searchTableView.numberOfRows(inSection: 0) > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.searchTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
}

