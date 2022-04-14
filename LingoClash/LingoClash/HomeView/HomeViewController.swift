//
//  HomeViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 13/3/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationSystem.setUpObservers()
        viewModel.refresh()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentBookTabBarVC = segue.destination as? CurrentBookTabBarController {
            currentBookTabBarVC.viewModel = self.viewModel
            guard let childVCs = currentBookTabBarVC.viewControllers else {
                return
            }
            for VC in childVCs {
                if let currentBookVC = VC as? CurrentBookViewController {
                    currentBookVC.viewModel = self.viewModel
                }
            }
        }
    }
}

