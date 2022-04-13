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
        NotificationSystem.instance.setUpNotifications()
//        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizCompleted(_:)), name: .lessonQuizCompleted, object: nil)
        viewModel.refresh()
        
    }
    
    @objc func lessonQuizCompleted(_ notification: Notification) {
        print("hello")
//        RewardSystem().generateReward(fromResult: <#T##LessonQuizResult#>)
//        print(notification.object as? [String: Any] ?? [:])
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

