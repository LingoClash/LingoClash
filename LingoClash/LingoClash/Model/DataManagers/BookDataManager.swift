//
//  BookDataManager.swift
//  LingoClash
//
//  Created by Kyle キラ on 22/3/22.
//

import Foundation

class BookDataManager: DataManager<Book> {
    
    init() {
        super.init(resource: "books")
    }
    
}
