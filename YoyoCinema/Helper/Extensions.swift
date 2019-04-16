//
//  Extensions.swift
//  YoyoCinema
//
//  Created by Boocha on 16/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView{
    func getPosterImage(with url: String){
        if let url = URL(string: url){
            Alamofire.request(url).response { response in
                if let data = response.data {
                    if let image = UIImage(data: data){
                        self.image = image
                    }
                } else {
                    print("Could not load the poster image.")
                }
            }
        }
    }
}

extension UIViewController{
    func displayAlert(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: userMessage, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func checkInternet() -> Bool{
        let internetManager = NetworkReachabilityManager()
        
        if internetManager!.isReachable{
            return true
        }else{
            displayAlert(userMessage: "Internet unreachable.")
            return false
        }
    }
    
    
}
