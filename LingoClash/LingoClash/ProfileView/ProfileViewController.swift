//
//  ProfileViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 13/3/22.
//

import Combine
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var totalStarsLabel: UILabel!
    @IBOutlet weak var starsTodayLabel: UILabel!
    
    private let viewModel = ProfileViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        viewModel.refreshProfile()
    }
    
    func setUpBinders() {
        viewModel.$name.sink {[weak self] name in
            if let name = name {
                self?.nameLabel.text = name
            }
        }.store(in: &cancellables)
        
        viewModel.$email.sink {[weak self] email in
            if let email = email {
                self?.emailLabel.text = email
            }
        }.store(in: &cancellables)
        
        viewModel.$totalStars.sink {[weak self] totalStars in
            if let totalStars = totalStars {
                self?.totalStarsLabel.text = "Total stars: \(totalStars)"
            }
        }.store(in: &cancellables)
        
        viewModel.$starsToday.sink {[weak self] starsToday in
            if let starsToday = starsToday {
                self?.starsTodayLabel.text = "Total stars today: \(starsToday)"
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            showLogOutPopUp()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func transitionToSplash() {
        let splashViewController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.splashVC) as? SplashViewController
        
        view.window?.rootViewController = splashViewController
        view.window?.makeKeyAndVisible()
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
