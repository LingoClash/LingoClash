//
//  RecommendedBooksTableViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 21/3/22.
//

import UIKit
import Combine

private let tableCellReuseIdentifier = "RecommendedBookTableCell"
private let headerReuseIdentifer = "CategoryHeader"

class RecommendedBooksTableViewController: UITableViewController {
    var booksForCategories = [BooksForCategory]()
    var viewModel: RecommendedBooksViewModel?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        viewModel?.refresh()
    }
    
    func setUpBinders() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.$booksForCategories.sink {[weak self] books in
            self?.booksForCategories = books
            self?.tableView.reloadData()
        }.store(in: &cancellables)
        
        viewModel.$isRefreshing.sink {[weak self] isRefreshing in
            if isRefreshing {
                self?.showSpinner()
            } else {
                self?.removeSpinner()
            }
        }.store(in: &cancellables)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return booksForCategories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let booksCell = tableView.dequeueReusableCell(withIdentifier: tableCellReuseIdentifier, for: indexPath) as? RecommendedBooksTableViewCell {
            
            booksCell.configure(books: booksForCategories[indexPath.section].books, delegate: self)
            cell = booksCell
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return booksForCategories[section].category
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension RecommendedBooksTableViewController: LearnButtonDelegate {
    func learnButtonTapped(book: Book) {
        
        let viewController = LessonSelectionViewController.instantiateFromAppStoryboard(.Lesson)
        viewController.viewModel = LessonSelectionViewModelFromBook(book: book)
        
        self.show(viewController, sender: nil)
        
        self.viewModel?.learnBook(book: book)
    }
}
