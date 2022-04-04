//
//  AccountOwner.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 3/4/22.
//

protocol AccountOwner {}

struct User: AccountOwner {
    var id: Identifier
    let book_id: Identifier
    let user_id: Identifier
}
