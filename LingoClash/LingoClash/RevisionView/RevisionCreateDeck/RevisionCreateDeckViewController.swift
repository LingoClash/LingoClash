//
//  RevisionCreateDeckViewController.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//
import UIKit
import Combine

class RevisionCreateDeckViewController: UIViewController {

    @IBOutlet weak var createDeckLabel: UITextField!
    //    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var totalStarsLabel: UILabel!
//    @IBOutlet weak var starsTodayLabel: UILabel!
    
//    private let viewModel = ProfileViewModel()
    private let viewModel = RevisionViewModel()
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
//    @IBAction func saveButtonTapped(_ sender: Any) {
//        let firstName = FormUtilities.getTrimmedString(textField: firstNameTextField)
//        let lastName = FormUtilities.getTrimmedString(textField: lastNameTextField)
//
//        let fields = EditProfileFields(firstName: firstName, lastName: lastName)
//        viewModel.editProfile(fields)
//    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        let fields = ChangeEmailFields(newEmail: newEmail)
        viewModel.changeEmail(fields)
    }
    
    // Create deck
    @IBAction func onTapActionSave(_ sender: Any) {
        let newDeckName = FormUtilities.getTrimmedString(textField: createDeckLabel)
        let newDeckFields = CreateDeckFields(newName: newDeckName)
        viewModel.addDeck(newDeckFields)
        print(newDeckName)
    }
}
