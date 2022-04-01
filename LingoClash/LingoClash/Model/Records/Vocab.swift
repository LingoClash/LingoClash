//
//  Level.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 23/3/22.
//

struct Vocab {
    var id: Identifier
    let definition: String
    let lesson_id: Identifier
    let sentence: String
    let word: String
}

extension Vocab: Record {}
