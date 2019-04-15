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

    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    func startAnimating(view: UIView) {
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 3)
        progressView.backgroundColor = .darkGray
        progressView.alpha = 0.6
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        view.addSubview(progressView)
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        progressView.removeFromSuperview()
    }
}
