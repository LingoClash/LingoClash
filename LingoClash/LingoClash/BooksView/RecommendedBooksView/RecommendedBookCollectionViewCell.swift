//
//  RecommendedBookCollectionViewCell.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 20/3/22.
//

import UIKit

class RecommendedBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var learnButton: UIButton!
    
    weak var delegate: LearnButtonDelegate?
    private var book: Book?
    
    func configure(book: Book, delegate: LearnButtonDelegate?) {
        bookNameLabel.text = book.name
        self.book = book
        self.delegate = delegate
    }
    
    @IBAction func learnButtonTapped(_ sender: UIButton) {
        guard let book = book else {
            return
        }
        self.delegate?.learnButtonTapped(book: book)
    }
}
