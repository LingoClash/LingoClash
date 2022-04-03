//
//  RevisionVocab.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

import Foundation

struct RevisionVocab {
//    var id: Identifier
    // Starts from 0
    var difficultyParameter: Difficulty
    var lastAttemptedDate: Date?
    var vocab: Vocab
}

struct Difficulty: Codable, Hashable {
    var amount: Int
}

extension RevisionVocab: Codable {}
extension RevisionVocab: Hashable {}
