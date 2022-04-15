//
//  Deck.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

struct Deck {
//    var id: Identifier
    let name: String
    var vocabs: [RevisionQuery]
    
    // can probably list the easy, med, hard vocabs next time
    var vocabNo: Int {
        get {
            vocabs.count
        }
    }
    
    init(name: String, vocabs: [RevisionVocab]) {
        self.name = name
        
        self.vocabs = vocabs.map{ RevisionQuery(vocab: $0, context: $0.vocab.word, answer: $0.vocab.definition)
        }
    }
    
}

extension Deck: Codable {}

