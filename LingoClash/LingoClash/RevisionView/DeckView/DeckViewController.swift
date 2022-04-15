//
//  DeckViewController.swift
//  LingoClash
//
//  Created by kevin chua on 12/4/22.
//

import UIKit
import Combine

class DeckViewController: UIViewController {

    @IBOutlet weak var createDeckLabel: UITextField!
    
    var viewModel: DeckViewModel?
    private var deck: Deck?
    private var revisionSequence: QuerySequence?
    private var currentQuery: RevisionQuery?
    
//        private let viewModel = DeckViewModel()
//    weak var viewModel: RevisionViewModel?
    //    @IBOutlet weak var nameLabel: UILabel!
    //    @IBOutlet weak var emailLabel: UILabel!
    //    @IBOutlet weak var totalStarsLabel: UILabel!
    //    @IBOutlet weak var starsTodayLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var wordsLeftLabel: UILabel!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideAnswer()
//        self.deckProgress = viewModel.deckProgress()
//        deckAddedNotif.isHidden = true
        setUpBinders()
        getFirstQuery()
    }
    
    private func setUpBinders() {
        viewModel?.$deck.sink {[weak self] deck in
            self?.deck = deck
        }.store(in: &cancellables)
        
        viewModel?.$revisionSequence.sink {[weak self] revisionSequence in
            self?.revisionSequence = revisionSequence
        }.store(in: &cancellables)
    }
    
    private func getFirstQuery() {
        let firstQuery = viewModel?.getNextQuery()
        contextLabel.text = firstQuery?.context
        
        // TODO: make query return an answer object which has a bunch of fields
        answerLabel.text = firstQuery?.answerToString
        
        self.currentQuery = firstQuery
//        let answer = firstQuery.answer
        
//        contextLabel.text = firstQuery?.context
    }

//    @IBAction func saveButtonTapped(_ sender: Any) {
    @IBOutlet weak var showAnswerButton: UIButton!
    //        let firstName = FormUtilities.getTrimmedString(textField: firstNameTextField)
//        let lastName = FormUtilities.getTrimmedString(textField: lastNameTextField)
//
//        let fields = EditProfileFields(firstName: firstName, lastName: lastName)
//        viewModel.editProfile(fields)
//    }
//    @IBAction func saveButtonTapped(_ sender: Any) {
//        let fields = ChangeEmailFields(newEmail: newEmail)
    @IBAction func answerDidTap(_ sender: Any) {
        hideAnswerButton()
        showAnswer()
    }
    //        viewModel.changeEmail(fields)
//    }
    @IBOutlet weak var againButton: UIButton!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    
    @IBOutlet weak var hardButton: UIButton!
    
    @IBAction func againDidTap(_ sender: Any) {
        let nextQuery = viewModel?.tapDifficulty(currentQuery: currentQuery, recallDifficulty: .again)
        recallDifficultyButtonTapped()
        setLabelToQuery(query: nextQuery)
    }
    
    @IBAction func hardDidTap(_ sender: Any) {
        let nextQuery = viewModel?.tapDifficulty(currentQuery: currentQuery, recallDifficulty: .hard)
        recallDifficultyButtonTapped()
        setLabelToQuery(query: nextQuery)
    }
    
    @IBAction func easyDidTap(_ sender: Any) {
        let nextQuery = viewModel?.tapDifficulty(currentQuery: currentQuery, recallDifficulty: .easy)
        recallDifficultyButtonTapped()
        setLabelToQuery(query: nextQuery)
    }
    
    @IBAction func goodDidTap(_ sender: Any) {
        let nextQuery = viewModel?.tapDifficulty(currentQuery: currentQuery, recallDifficulty: .good)
        recallDifficultyButtonTapped()
        setLabelToQuery(query: nextQuery)
    }
    
    
    private func setLabelToQuery(query: RevisionQuery?) {
        contextLabel.text = query?.context
        answerLabel.text = query?.answerToString
        exampleLabel.text = query?.revVocab.vocab.sentence
        
    }

    
    func recallDifficultyButtonTapped() {
        unhideAnswerButton()
//        hideRecallButtons()
    }
    
    private func hideRecallButtons() {
        againButton.isHidden = true
        easyButton.isHidden = true
        goodButton.isHidden = true
        hardButton.isHidden = true
    }
    
    private func showRecallButtons() {
        againButton.isHidden = false
        easyButton.isHidden = false
        goodButton.isHidden = false
        hardButton.isHidden = false
    }
        
    private func hideAnswerButton() {
        showAnswerButton.isHidden = true
    }
    
    private func unhideAnswerButton() {
        showAnswerButton.isHidden = false
    }
    
    private func showAnswer() {
        exampleLabel.isHidden = false
        answerLabel.isHidden = false
    }
    
    private func hideAnswer() {
        exampleLabel.isHidden = true
        answerLabel.isHidden = true
    }
    
}
