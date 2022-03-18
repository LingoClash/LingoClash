//
//  LingoClashTests.swift
//  LingoClashTests
//
//  Created by Kyle キラ on 12/3/22.
//

import XCTest
@testable import LingoClash

class LingoClashTests: XCTestCase {

    func testDataManager_fetchesCorrectly() {
        let bookDataManager = BookDataManager()
        let books = bookDataManager.getList(page: 1)
        
        books.done { books in
            print(books)
            XCTAssertTrue(false)
            XCTAssertEqual(books, [
                LingoClash.Book(id: "8", category_id: "3", name: "HSK 2"), LingoClash.Book(id: "7", category_id: "3", name: "HSK 1"), LingoClash.Book(id: "6", category_id: "2", name: "TOPIK 2"), LingoClash.Book(id: "5", category_id: "2", name: "TOPIK 1"), LingoClash.Book(id: "4", category_id: "1", name: "JLPT N4"), LingoClash.Book(id: "3", category_id: "1", name: "JLPT N5"), LingoClash.Book(id: "2", category_id: "1", name: "Minna No Nihongo 2"), LingoClash.Book(id: "1", category_id: "1", name: "Minna No Nihongo 1")
                ]
            )
        }.catch { error in
            print("Error: ", error)
        }
        
//        let booksOne = bookDataManager.getOne(id: "8")
//        booksOne.done ({ books in
//            XCTAssertEqual(books, [
//                LingoClash.Book(id: "8", category_id: "3", name: "HSK 2"), LingoClash.Book(id: "7", category_id: "3", name: "HSK 1"), LingoClash.Book(id: "6", category_id: "2", name: "TOPIK 2"), LingoClash.Book(id: "5", category_id: "2", name: "TOPIK 1"), LingoClash.Book(id: "4", category_id: "1", name: "JLPT N4"), LingoClash.Book(id: "3", category_id: "1", name: "JLPT N5"), LingoClash.Book(id: "2", category_id: "1", name: "Minna No Nihongo 2"), LingoClash.Book(id: "1", category_id: "1", name: "Minna No Nihongo 1")
//                ]
//            )
//        }).catch { error in
//            print("Error: ", error)
//        }
        
        let booksMany = bookDataManager.getMany(ids: ["1", "8"])
        booksMany.done { books in
            print(books)
            XCTAssertEqual(books, [
                LingoClash.Book(id: "8", category_id: "3", name: "HSK 2"), LingoClash.Book(id: "7", category_id: "3", name: "HSK 1"), LingoClash.Book(id: "6", category_id: "2", name: "TOPIK 2"), LingoClash.Book(id: "5", category_id: "2", name: "TOPIK 1"), LingoClash.Book(id: "4", category_id: "1", name: "JLPT N4"), LingoClash.Book(id: "3", category_id: "1", name: "JLPT N5"), LingoClash.Book(id: "2", category_id: "1", name: "Minna No Nihongo 2"), LingoClash.Book(id: "1", category_id: "1", name: "Minna No Nihongo 1")
                ]
            )
        }.catch { error in
            print("Error: ", error)
        }
        
        let booksManyOne = bookDataManager.getMany(ids: ["1"])
        booksManyOne.done { books in
            print(books)
            XCTAssertEqual(books, [
                LingoClash.Book(id: "8", category_id: "3", name: "HSK 2"), LingoClash.Book(id: "7", category_id: "3", name: "HSK 1"), LingoClash.Book(id: "6", category_id: "2", name: "TOPIK 2"), LingoClash.Book(id: "5", category_id: "2", name: "TOPIK 1"), LingoClash.Book(id: "4", category_id: "1", name: "JLPT N4"), LingoClash.Book(id: "3", category_id: "1", name: "JLPT N5"), LingoClash.Book(id: "2", category_id: "1", name: "Minna No Nihongo 2"), LingoClash.Book(id: "1", category_id: "1", name: "Minna No Nihongo 1")
                ]
            )
        }.catch { error in
            print("Error: ", error)
        }
        
//        let booksMany = bookDataManager.getManyReference(id: ["1", "8"])
//        booksMany.done { books in
//            XCTAssertEqual(books, [
//                LingoClash.Book(id: "8", category_id: "3", name: "HSK 2"), LingoClash.Book(id: "7", category_id: "3", name: "HSK 1"), LingoClash.Book(id: "6", category_id: "2", name: "TOPIK 2"), LingoClash.Book(id: "5", category_id: "2", name: "TOPIK 1"), LingoClash.Book(id: "4", category_id: "1", name: "JLPT N4"), LingoClash.Book(id: "3", category_id: "1", name: "JLPT N5"), LingoClash.Book(id: "2", category_id: "1", name: "Minna No Nihongo 2"), LingoClash.Book(id: "1", category_id: "1", name: "Minna No Nihongo 1")
//                ]
//            )
//        }.catch { error in
//            print("Error: ", error)
//        }
    }

}
