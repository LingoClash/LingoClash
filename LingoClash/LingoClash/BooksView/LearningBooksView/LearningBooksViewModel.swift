//
//  LearningBooksViewModel.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 20/3/22.
//

import Foundation
import Combine
import PromiseKit

final class LearningBooksViewModel: BooksViewModel {

    @Published var books: [Book]?
    var booksPublisher: Published<[Book]?>.Publisher {
        $books
    }

    private let bookManager = BookManager()
    private let profileManager = ProfileManager()

    func refresh() {
        firstly {
            bookManager.getLearningBooks()
        }.done { books in
            self.books = books
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
    
    func learnBook(bookId: Identifier) {
        firstly {
            profileManager.setAsCurrentBook(bookId: bookId)
        }.catch { error in
            Logger.error("\(error)")
        }
    }
}
