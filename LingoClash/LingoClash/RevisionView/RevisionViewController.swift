//
//  RevisionViewController.swift
//  LingoClash
//
//  Created by kevin chua on 26/3/22.
//
import UIKit
import Combine

private let reuseIdentifier = "DeckTableViewCell"

class RevisionViewController: UIViewController {
    
    enum Segue {
        static let gotoDeck = "gotoDeck"
    }
    
    @IBOutlet weak var revisionTableView: UITableView!
    private var decks: [Deck]?
//    private var decksProgress: [DeckProgress] = []
    
    private let viewModel = RevisionViewModel()
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var totalStarsLabel: UILabel!
//    @IBOutlet weak var deckCollection: UILabel!
    
//    private let viewModel = ProfileViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var selectedDeck: Deck?

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.refreshDecks()
        self.viewModel.fetchDecks()
        
        setUpBinders()
        revisionTableView.dataSource = self
        revisionTableView.delegate = self
    }

    private func setUpBinders() {
        viewModel.$decks.sink {[weak self] decks in
            self?.decks = decks
            // initialise decks progress as well
//            self?.decksProgress = decks.map({DeckProgress(name: $0.name, progress: $0.vocabNo)})
            
            self?.revisionTableView.reloadData()
        }.store(in: &cancellables)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createDeckVC = segue.destination as? RevisionCreateDeckViewController {
            createDeckVC.viewModel = self.viewModel
        } else if let deckVC = segue.destination as? DeckViewController {
            guard let selectedDeck = self.selectedDeck else {
                return
            }
            
            deckVC.viewModel = DeckViewModel(deck: selectedDeck)
        }
    }
}

extension RevisionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.decks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let deckCell = tableView
                .dequeueReusableCell(
                    withIdentifier: reuseIdentifier) as? DeckTableViewCell else {
            fatalError("Failure obtaining reusable vocabs learnt table view cell")
        }

//        deckCell.configure(deckName: "IDIOT", vocabNo: "IDIOT")
        
        deckCell.configure(deckName: self.decks?[indexPath.row].name ?? "", vocabNo: String(self.decks?[indexPath.row].vocabNo ?? 0))

//        cell.vocabWord = viewModel?.vocabsLearnt[indexPath.row] ?? ""
        return deckCell
    }
}

extension RevisionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set it to the correct viewmodel
        let selectedDeck = decks?[indexPath.section]
        self.selectedDeck = selectedDeck
        
        // then do a segue
        performSegue(withIdentifier: Segue.gotoDeck, sender: self)
    }
}
