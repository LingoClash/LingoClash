//
//  RecommendedBooksViewModel.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 21/3/22.
//

import Combine
import PromiseKit

final class RecommendedBooksViewModel {
    @Published var booksForCategories: [BooksForCategory]?

    private let bookManager = BookManager()

    func refresh() {
        firstly {
            bookManager.getRecommendedBooks()
        }.done { booksForCategories in
            self.booksForCategories = booksForCategories
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }

    func learnBook(book: Book) {
        bookManager.markAsLearning(book: book).catch { error in
            Logger.error(error.localizedDescription)
        }
    }
}
