//
//  SearchManager.swift
//  YoyoCinema
//
//  Created by Boocha on 14/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation
import Alamofire

class SearchManager: NSObject{
    
    private var movies = [Movie]()
    
    static let shared = SearchManager()
    
    func requestSearchResults(with searchString: String, completionHandler: @escaping (_ success: Bool) -> Void ){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=4cb1eeab94f45affe2536f2c684a5c9e&query=\(searchString)") else {
            completionHandler(false)
            return
        }
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    print(response.value as Any)
                    completionHandler(true)
                    
                    
                case .failure(let error):
                    print(error)
                    completionHandler(false)
                }
        }

        
    }
    
}

extension SearchManager: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
