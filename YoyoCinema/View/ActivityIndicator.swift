//
//  ActivityIndicator.swift
//  YoyoCinema
//
//  Created by Boocha on 15/04/2019.
//  Copyright © 2019 JiriB. All rights reserved.
//

import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()

    var frameView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func startAnimating(view: UIView) {
        frameView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        frameView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 3)
        frameView.backgroundColor = .darkGray
        frameView.alpha = 0.6
        frameView.clipsToBounds = true
        frameView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: frameView.bounds.width / 2, y: frameView.bounds.height / 2)
        
        frameView.addSubview(activityIndicator)
        view.addSubview(frameView)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        frameView.removeFromSuperview()
    }
}
