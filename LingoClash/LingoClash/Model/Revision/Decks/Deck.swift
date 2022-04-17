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
        
        self.vocabs = vocabs.map{ RevisionQuery(vocab: $0) }
    }
    
    init(deckData: DeckData, vocabDataArr: [VocabData]) {
        self.name = deckData.name
        
        self.vocabs = vocabDataArr.map{ vocabData in
            let revisionVocab = RevisionVocab(id: vocabData.id,
                                                vocab: Vocab(vocabData: vocabData), difficultyParameter: Difficulty(amount: 0))
            return RevisionQuery(vocab: revisionVocab)
        }
    }
    
    init(deckData: DeckData, revisionVocabDataArr: [RevisionVocabData], vocabDataArr: [VocabData]) {
        self.name = deckData.name
        
        self.vocabs = vocabDataArr.enumerated().map{ (index, vocabData) in
            
            let revisionVocab = RevisionVocab(
                id: revisionVocabDataArr[index].id,
                vocab: Vocab(vocabData: vocabData),
                difficultyParameter: Difficulty(amount: 0),
                lastAttemptedDate: revisionVocabDataArr[index].last_attempted_date
            )
            return RevisionQuery(vocab: revisionVocab,
                                 difficulty: Difficulty(amount: 0),
                                 lastAttemptedDate: nil
            )
        }
        
    }
}

extension Deck: Codable {}

