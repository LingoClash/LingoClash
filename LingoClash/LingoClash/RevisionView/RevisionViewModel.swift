//
//  RevisionViewModel.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

import Combine

final class RevisionViewModel {
    
//    @Published var currentBookProgress: BookProgress?
//    @Published var currentBook: Book?
//    @Published var lessonSelectionViewModel: LessonSelectionViewModel?
    @Published var decks: [Deck] = [Deck(name: "Default Deck", vocabs: [])]
    
    func fetchDecks() {
        //TODO: get current decks from db
    //        self.currentBookProgress = BookProgress(name: "Chinese 1", progress: "0/10")
    //        self.currentBook = Book(id: "1", category_id: "1", name: "Chinese 1")
    //        guard let currentBook = currentBook else {
    //            return
    //        }
    //        self.lessonSelectionViewModel = LessonSelectionViewModelFromBook(book: currentBook)
        
    }
    
    func addDeck(_ deckFields: CreateDeckFields) {
        // update locally
        decks.append(Deck(name: deckFields.newName, vocabs: []))
        
    }
    
    func refreshDecks() {
        // todo: fetch decks as well
    }
}
