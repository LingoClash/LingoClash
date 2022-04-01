//
//  RevisionViewController.swift
//  LingoClash
//
//  Created by kevin chua on 26/3/22.
//
import UIKit
import Combine

class RevisionViewController: UIViewController {

//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var totalStarsLabel: UILabel!
//    @IBOutlet weak var starsTodayLabel: UILabel!
    
//    private let viewModel = ProfileViewModel()
    private let viewModel = CurrentBookViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBinders()
    }

    private func setUpBinders() {
        // Add binders
//        viewModel.$currentBookProgress.sink {[weak self] bookProgress in
//            if let bookProgress = bookProgress {
//                self?.bookNameLabel.text = bookProgress.name
//                self?.progressLabel.text = "Progress: \(bookProgress.progress)"
//            }
//        }.store(in: &cancellables)
    }

    func showError(_ message: String) {
        // TODO: Perhaps it is better to show as popup
//        Log.info("Error signing out: \(message)")
    }
    @IBAction func reviseTapped(_ sender: Any) {
        print("I tapped revise")
    }

}
