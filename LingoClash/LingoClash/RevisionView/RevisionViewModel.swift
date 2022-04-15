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
    @Published var decks: [Deck] = []
    
    // remove this
    func createRevisionVocabs() -> [RevisionVocab] {
        let vocabs = [
            Vocab(vocabId: 1, word: "周", definition: "week", sentence: "一周有七天。",
                  sentenceDefinition: "Every week has 7 days.", pronunciationText: "zhōu"),
            Vocab(vocabId: 2, word: "今天", definition: "today", sentence: "她今天看起来很悲伤。",
                  sentenceDefinition: "She looks saf today.", pronunciationText: "jīntiān"),
            Vocab(vocabId: 3, word: "明天", definition: "tomorrow", sentence: "明天10：10",
                  sentenceDefinition: " tomorrow at 10:10", pronunciationText: "míngtiān"),
            Vocab(vocabId: 4, word: "昨天", definition: "yesterday", sentence: "她今天看起来很悲伤。",
                  sentenceDefinition: "She looks saf today.", pronunciationText: "jīntiān"),
            Vocab(vocabId: 5, word: "日历", definition: "calendar", sentence: "她今天看起来很悲伤。",
                  sentenceDefinition: "She looks saf today.", pronunciationText: "jīntiān"),
            Vocab(vocabId: 6, word: "秒", definition: "second", sentence: "她今天看起来很悲伤。",
                  sentenceDefinition: "She looks saf today.", pronunciationText: "jīntiān")
        ]
        var vocabArr: [RevisionVocab] = []
        
        for vocab in vocabs {
            vocabArr.append(
                RevisionVocab(difficultyParameter: Difficulty(amount: 0), vocab: vocab)
            )
        }
        
        return vocabArr
    }

    func fetchDecks() {
        // TODO: get current decks from db with their correct names
        decks.append(Deck(name: "Default Deck", vocabs: createRevisionVocabs()))
        
    //        self.currentBookProgress = BookProgress(name: "Chinese 1", progress: "0/10")
    //        self.currentBook = Book(id: "1", category_id: "1", name: "Chinese 1")
    //        guard let currentBook = currentBook else {
    //            return
    //        }
    //        self.lessonSelectionViewModel = LessonSelectionViewModelFromBook(book: currentBook)
    }
    
    func deckProgress() {
        
    }
    
    func addDeck(_ deckFields: CreateDeckFields) {
        // update locally
        decks.append(Deck(name: deckFields.newName, vocabs: []))
        print(decks)
        // TODO: send an api request if possible
    }
    
    func refreshDecks() {
        // todo: fetch decks as well
    }
}
