//
//  AddToDeckViewModel.swift
//  LingoClash
//
//  Created by kevin chua on 17/4/22.
//

import Foundation
import PromiseKit

final class AddToDeckViewModel {
    @Published var decks: [Deck] = []
    @Published var isRefreshing = false

    var vocab: Vocab
    
    init(vocab: Vocab) {
        self.vocab = vocab
    }
    
    func addVocabToDeck(deck: Deck) {
        DeckManager().addVocabToDeck(deck: deck, vocab: vocab)
    }

    func fetchDecks() {
        self.decks = []
        self.isRefreshing = true
        
        DeckManager().getDecksFromProfileId().done { deckArr in
            self.decks.append(contentsOf: deckArr)
            self.isRefreshing = false
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
}
