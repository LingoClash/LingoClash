//
//  DeckCollectionViewCell.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckNameLabel: UILabel!
//    @IBOutlet weak var progressLabel: UILabel!
//    @IBOutlet weak var PKButton: UIButton!
    @IBOutlet weak var reviseButton: UIButton!
//    @IBOutlet weak var learnButton: UIButton!
    
    // TODO: decide what kind of progress I want to do (number of words not done? or smth)
    @IBOutlet weak var progressLabel: UILabel!
    
    
    func configure(deckName: String, progress: String) {
        deckNameLabel.text = deckName
        progressLabel.text = "Progress: \(progress)"
    }
}
