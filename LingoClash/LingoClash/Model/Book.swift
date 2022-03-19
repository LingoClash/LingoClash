//
//  Book.swift
//  LingoClash
//
//  Created by Kyle キラ on 15/3/22.
//

import Foundation

struct Book {
//    let id: Identifier Firebase does not have this
    let books_category_id: Identifier
    let name: String
}

extension Book: Codable {}
