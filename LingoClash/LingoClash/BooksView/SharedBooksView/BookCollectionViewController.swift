//
//  BookCollectionViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 20/3/22.
//

import UIKit
import Combine

private let reuseIdentifier = "BookCell"

class BookCollectionViewController: UICollectionViewController {
    
    @IBOutlet private var emptyView: UIView!
    
    var books: [Book]?
    var viewModel: BooksViewModel?
    weak var parentVC: UIViewController?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        viewModel?.refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.refresh()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.parentVC?.showSpinner()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let books = books else {
            return
        }

        self.parentVC?.removeSpinner()
        if books.count == 0 {
            collectionView.backgroundView = emptyView
        } else {
            collectionView.backgroundView = nil
        }
    }

    func setUpBinders() {
        guard let viewModel = viewModel else {
            return
        }

        viewModel.booksPublisher.sink {[weak self] books in
            self?.books = books
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books?.count ?? 0
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
            
        guard let books = books else {
            return cell
        }

        if let bookCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? BookCollectionViewCell {

            bookCell.configure(book: books[indexPath.row], delegate: self)

            ViewUtilities.styleCard(bookCell)

            cell = bookCell
        }

        return cell
    }
}

extension BookCollectionViewController: BookButtonDelegate {
    func learnButtonTapped(book: Book) {
        
        let viewController = LessonSelectionViewController.instantiateFromAppStoryboard(.Lesson)
        viewController.viewModel = LessonSelectionViewModelFromBook(book: book)
        
        self.show(viewController, sender: nil)
        
        self.viewModel?.learnBook(bookId: book.id)
    }
}
