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

    func fetchDecks() {
        self.decks = []
        self.isRefreshing = true
        
        firstly {
            ProfileManager().getCurrentProfile()
        }.then { currentProfile in
            DeckManager().getDecks(profileId: currentProfile.id)
        }.done { deckArr in
            self.decks.append(contentsOf: deckArr)
            self.isRefreshing = false
        }.catch { error in
            Logger.error("\(error)")
        }
    }
}
