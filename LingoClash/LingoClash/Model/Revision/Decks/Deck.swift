//
//  Deck.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

struct Deck {
//    var id: Identifier
    let name: String
    var vocabs: [RevisionVocab]
}

extension Deck: Codable {}
