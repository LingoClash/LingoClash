//
//  DeckManager.swift
//  LingoClash
//
//  Created by kevin chua on 15/4/22.
//

import Foundation
import PromiseKit

class DeckManager: DataManager<DeckData> {
    enum FetchingErrors: Error {
        case alreadyExist
    }
    
    init() {
        super.init(resource: DataManagerResources.decks)
    }
    
    func addDeck(newDeckFields: CreateDeckFields) {
        firstly {
            ProfileManager().getCurrentProfile()
        }.done { currentProfile in
            self.create(newRecord:
                            DeckData(id: "-1", name: newDeckFields.newName, profile_id: currentProfile.id, revision_vocab_id: [])
            ).catch { error in
                Logger.error(error.localizedDescription)
            }
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
    
    func getDecksFromProfileId() -> Promise<[Deck]> {
        firstly {
            ProfileManager().getCurrentProfile()
        }.then { currentProfile in
            DeckManager().getDecks(profileId: currentProfile.id)
        }
    }
    
    
    func getDecks(profileId: Identifier) -> Promise<[Deck]> {
        var revisionVocabByDeckData: [DeckData: [RevisionVocabData]] = [:]
        var vocabByDeckData: [DeckData: [VocabData]] = [:]
        // .then to chain it to VocabByDeckId
        // take in [DeckData], [VocabByDeckId] -> [Deck]

        return firstly {
            // first, fetch decks
            DeckManager().getManyReference(target: "profile_id", id: profileId)
        }.then { deckDataArr -> Promise<Void> in
            let revisionVocabPromises = deckDataArr.map { deckData -> Promise<Void> in
                firstly {
                    RevisionVocabManager().getManyReference(target: "deck_id", id: String(deckData.id))
                }.done { revisionVocabsData in
                    revisionVocabByDeckData[deckData] = revisionVocabsData
                }
            }
            // returns [RevisionVocabData]
            return when(fulfilled: revisionVocabPromises)
        }.then { _ -> Promise<Void> in
            var vocabPromises = [Promise<Void>]()
            // [Promise<VocabData>]
            for (deckData, revisionVocabData) in revisionVocabByDeckData {
                guard revisionVocabData.count > 0 else {
                    vocabByDeckData[deckData] = []
                    continue
                }
                vocabPromises.append(
                    firstly {
                        VocabManager().getMany(ids: revisionVocabData.map{$0.vocab_id})
                    }.done { vocabData in
                        vocabByDeckData[deckData] = vocabData
                    }
                )
            }
            return when(fulfilled: vocabPromises)
        }.map { () -> [Deck] in
            var deckArr = [Deck]()
            // convert [DeckData] into
            for (deckData, vocabData) in vocabByDeckData {
                deckArr.append(
                    Deck(deckData: deckData,
                         revisionVocabDataArr: revisionVocabByDeckData[deckData] ?? [],
                         vocabDataArr: vocabData
                    )
                )
            }
            return deckArr.sorted()
        }
    }
    
    func addVocabToDeck(deck: Deck, vocab: Vocab) {
        let revisionVocabData = RevisionVocabData(id: "-1", difficulty: 0, last_attempted_date: nil, vocab_id: vocab.id, deck_id: deck.id)
        // Check if there is a duplicate in the database before adding
        firstly {
            RevisionVocabManager().getOneReference(target: "vocab_id", id: vocab.id, filter: ["deck_id": deck.id])
        }.then { revisionVocabData -> Promise<Void> in
            if let revisionVocabData = revisionVocabData {
                Logger.info("Revision Vocab \(revisionVocabData) already exists. Terminating request")
                throw FetchingErrors.alreadyExist
            }
            return Promise()
        }.then { _ in
            RevisionVocabManager().create(newRecord: revisionVocabData)
        }.done { _ in
            Logger.info("Successfully added \(revisionVocabData) to Deck \(deck)")
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
    
}
