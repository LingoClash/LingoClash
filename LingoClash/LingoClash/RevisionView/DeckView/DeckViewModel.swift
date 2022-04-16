//
//  DeckViewModel.swift
//  LingoClash
//
//  Created by kevin chua on 13/4/22.
//

import Foundation

final class DeckViewModel {
    
//    @Published var currentBookProgress: BookProgress?
//    @Published var currentBook: Book?
//    @Published var lessonSelectionViewModel: LessonSelectionViewModel?
//    @Published var decks: [Deck] = [Deck(name: "Default Deck", vocabs: [])]
    
    @Published var deck: Deck
    
    @Published var revisionSequence: RevisionSequence

    init(deck: Deck) {
        self.deck = deck
        self.revisionSequence = RevisionSequence(deck: deck)
    }
    
    func addToQueue(currentQuery: RevisionQuery?, recallDifficulty: RecallDifficulty) {
        guard let currentQuery = currentQuery else {
            return
        }
        
        // make the question go back to the queue with the specified difficulty
        let newQuery = RevisionQuery(
            vocab: currentQuery.revVocab,
            context: currentQuery.context,
            answer: currentQuery.answerToString,
            difficulty: Difficulty(amount: recallDifficulty.rawValue),
            lastAttemptedDate: Date()
        )
        
        self.revisionSequence.insert(newQuery)
    }

//    func tapDifficulty(currentQuery: RevisionQuery?, recallDifficulty: RecallDifficulty) -> RevisionQuery? {
//
//        addToQueue(currentQuery: currentQuery, recallDifficulty: recallDifficulty)
//
//        print(revisionSequence)
//        print(currentQuery.magnitude)
//
//        return revisionSequence.next() as? RevisionQuery
//    }

    func getNextQuery() -> RevisionQuery? {
        let nextQuery = revisionSequence.next() as? RevisionQuery
        return nextQuery
    }
    
    
    
    
//    func fetchDecks() {
//        // TODO: get current decks from db
//        decks.append(Deck(name: "default Deck", vocabs: []))
//
//    //        self.currentBookProgress = BookProgress(name: "Chinese 1", progress: "0/10")
//    //        self.currentBook = Book(id: "1", category_id: "1", name: "Chinese 1")
//    //        guard let currentBook = currentBook else {
//    //            return
//    //        }
//    //        self.lessonSelectionViewModel = LessonSelectionViewModelFromBook(book: currentBook)
//    }
//
//    func deckProgress() {
//
//    }
//
//    func addDeck(_ deckFields: CreateDeckFields) {
//        // update locally
//        decks.append(Deck(name: deckFields.newName, vocabs: []))
//        print(decks)
//        // TODO: send an api request if possible
//    }
//
//    func refreshDecks() {
//        // todo: fetch decks as well
//    }
}
