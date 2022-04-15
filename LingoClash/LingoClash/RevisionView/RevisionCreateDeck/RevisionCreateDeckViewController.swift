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
    weak var viewModel: RevisionViewModel?
    private var cancellables: Set<AnyCancellable> = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.deckProgress = viewModel.deckProgress()
        deckAddedNotif.isHidden = true
        setUpBinders()
    }
    
    private func setUpBinders() {

    }

//    @IBAction func saveButtonTapped(_ sender: Any) {
//        let firstName = FormUtilities.getTrimmedString(textField: firstNameTextField)
//        let lastName = FormUtilities.getTrimmedString(textField: lastNameTextField)
//
//        let fields = EditProfileFields(firstName: firstName, lastName: lastName)
//        viewModel.editProfile(fields)
//    }
//    @IBAction func saveButtonTapped(_ sender: Any) {
//        let fields = ChangeEmailFields(newEmail: newEmail)
//        viewModel.changeEmail(fields)
//    }
    
    @IBOutlet weak var deckAddedNotif: UILabel!
    // Create deck
    @IBAction func onTapActionSave(_ sender: Any) {
        let newDeckName = FormUtilities.getTrimmedString(textField: createDeckLabel)
        let newDeckFields = CreateDeckFields(newName: newDeckName)
        viewModel?.addDeck(newDeckFields)
//        print(newDeckName)
        
        // TODO: Put this in the callback after the API has returned
        createDeckLabel.text = ""
        deckAddedNotif.isHidden = false
    }
}
