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
        } else if let pkLobbyVC = segue.destination as? PKGameLobbyViewController {
            guard let pkLobbyVM = self.viewModel.pkGameLobbyViewModel else {
                return
            }
            pkLobbyVC.viewModel = pkLobbyVM
        }
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        self.viewModel.refresh()
    }
}

