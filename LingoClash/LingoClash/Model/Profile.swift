//
//  Profile.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 23/3/22.
//

struct Profile {
    var id: Identifier
    let book_id: Identifier
    let stars: Int
    let stars_today: Int
    let profile_book_ids: [Identifier]
}

extension Profile: Codable {}
