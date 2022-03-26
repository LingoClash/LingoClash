//
//  Vocab.swift
//  LingoClash
//
//  Created by Sherwin Poh on 19/3/22.
//

import Foundation

struct Vocab {
    let vocabId: Int
    let word: String
    let definition: String
    let sentence: String
    let sentenceDefinition: String
    let pronunciationText: String
    // TODO: Add pronunciation
}

extension Vocab: Codable {}
extension Vocab: Hashable {}