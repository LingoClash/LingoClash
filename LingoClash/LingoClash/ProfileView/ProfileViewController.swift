//
//  ProfileViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 13/3/22.
//

import UIKit
import Combine
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let viewModel = ProfileViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinders()
    }
    
    func setUpBinders() {
        viewModel.$error.sink {[weak self] error in
            if let error = error {
                self?.showError(error)
            } else {
                self?.showLogOutPopUp()
//                self?.transitionToHome()
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
//        do {
////            try Auth.auth().signOut()
//
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//
        // TODO: 
        viewModel.signOut()
    }
    
    func transitionToSplash() {
        let splashViewController = storyboard?.instantiateViewController(withIdentifier: AppConfigs.StoryBoard.splashVC) as? SplashViewController
        
        view.window?.rootViewController = splashViewController
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message: String) {
        // TODO: Perhaps it is better to show as popup
        print("Error signing out: %@", message)
    }
    
    func showLogOutPopUp() {
        let title = ""
        let message = "Are you sure you want to log out?"
        let alert = Utilities.createAlert(title: title, message: message)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
            self.transitionToSplash()
        })
        self.present(alert, animated: true, completion: nil)
    }
}
