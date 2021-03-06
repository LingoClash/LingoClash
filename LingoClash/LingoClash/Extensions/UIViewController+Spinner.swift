//
//  UIViewController+Spinner.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 8/4/22.
//

import UIKit

private var spinnerView: UIView?

extension UIViewController {

    func showSpinner() {
        if spinnerView != nil {
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
        
        let activityView = UIView(frame: self.view.bounds)
        let activityIndicator = UIActivityIndicatorView(
            style: .large)
        activityIndicator.center = activityView.center
        activityIndicator.startAnimating()
        
        activityIndicator.color = Theme.current.primary
        
        activityView.addSubview(activityIndicator)
        self.view.addSubview(activityView)
        spinnerView = activityView
    }

    func removeSpinner() {
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }

}

