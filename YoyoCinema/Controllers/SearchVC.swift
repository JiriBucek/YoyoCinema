//
//  ViewController.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var searchAPI = SearchAPI.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.tableFooterView = UIView()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        let nib = UINib.init(nibName: "NoResultsCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "NoResultsCell")
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if checkInternet(){
            if segue.identifier == "movieDetailSegue" {
                let movieDetailVC = segue.destination as! MovieDetailVC
                guard let indexPath = searchTableView.indexPathForSelectedRow, let movieId = searchAPI.movieForIndexPath(indexPath: indexPath)?.id else {
                    return
                }
                movieDetailVC.id = movieId
            }
        }
    }
}


extension SearchVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewCell", for: indexPath) as! MoviePreviewCell
        
        if let movie = searchAPI.movieForIndexPath(indexPath: indexPath){
        // Results returned by API
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.description
            
            cell.movieImage.image = nil
            if let imageUrl = movie.imageUrl{
                cell.movieImage.getPosterImage(with: imageUrl)
            }
        }else{
        // Zero search resuts
            let noResultCell = tableView.dequeueReusableCell(withIdentifier: "NoResultsCell") as! NoResultsCell
            return noResultCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = searchAPI.numberOfRows()
        if numberOfRows == 0, let searchText = searchBar.text, !searchText.isEmpty{
            // Displays NoResults table view cell
            return 1
        }else{
            return numberOfRows
        }
    }
}


extension SearchVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if checkInternet(){
            searchTableView.isHidden = true
            ActivityIndicator.shared.startAnimating(view: backgroundView)
            
            searchAPI.requestSearchResults(with: searchText){ success in
                if success{
                    self.searchTableView.reloadData()
                    ActivityIndicator.shared.stopAnimating()
                    self.searchTableView.isHidden = false
                    
                    if self.searchTableView.numberOfRows(inSection: 0) > 0 {
                        // Scrolls back to top when user types a letter.
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.searchTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }
                }else{
                    self.displayAlert(userMessage: "Could not load data. Please try again later.")
                }
            }
        }
    }
}

