//
//  FirebaseBook.swift
//  LingoClash
//
//  Created by kevin chua on 19/3/22.
//

import Foundation

struct FirebaseBook {
    let books_category_id: [String: String]
    let name: [String: String]
    let fields: [String: [String: String]]
}

extension FirebaseBook: Codable {}
