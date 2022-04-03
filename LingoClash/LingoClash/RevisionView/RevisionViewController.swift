//
//  RevisionViewController.swift
//  LingoClash
//
//  Created by kevin chua on 26/3/22.
//
import UIKit
import Combine

class RevisionViewController: UIViewController {

    private let reuseIdentifier = "DeckCell"
    
    var myDeckCollection: [Deck] = []
    
    private let viewModel = RevisionViewModel()
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
//    @IBOutlet weak var totalStarsLabel: UILabel!
//    @IBOutlet weak var deckCollection: UILabel!
    
//    private let viewModel = ProfileViewModel()
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refreshDecks()
        setUpBinders()
    }

    private func setUpBinders() {
        // Add binders
        viewModel.$decks.sink {[weak self] deck in
            self?.myDeckCollection = deck
//            if let deck = deck {
//                self?.myDeckCollection = deck
//                self?.progressLabel.text = "Progress: \(bookProgress.progress)"
//            }
        }.store(in: &cancellables)

    }

    func showError(_ message: String) {
        // TODO: Perhaps it is better to show as popup
//        Log.info("Error signing out: \(message)")
    }
    // @IBAction func reviseTapped(_ sender: Any) {
    //     print("I tapped revise")
    // }


//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return myDeckCollection.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        var cell = UICollectionViewCell()
//
//        if let deckCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BookCollectionViewCell {
//
//            deckCell.configure(bookName: myDeckCollection[indexPath.row].name, progress: "0")
//
//            ViewUtilities.styleCard(deckCell)
//
//            cell = deckCell
//        }
//
//        return cell
//    }

}
