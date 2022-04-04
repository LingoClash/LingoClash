//
//  RevisionSequence.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

// TODO: add a sequence protocol

/// Note that not all RevisionVocabs need to be tested. They are sorted by a priority queue and only up to a certain
/// day difference they will be tested
///
/// This is just a wrapper around the factory, with a count and when it hits zero it returns null
struct RevisionSequence {
    var scopeFactory: RevisionScopeFactory
    var constructorFactory: QuestionConstructorRandomFactory
    var questionsLeft: Int?
    
//    mutating func next() -> Question? {
//        if let questionsLeft = questionsLeft {
//            guard questionsLeft > 0 else {
//                return nil
//            }
//            self.questionsLeft = questionsLeft - 1
//        }
//        let constructor = constructorFactory.getQuestionConstructor()
//        let (testedVocab, otherVocabs) = scopeFactory.getScope(for: constructor)
//        let question = constructor.constructQuestion(vocabsTested: testedVocab, otherVocabs: otherVocabs)
//        return question
//    }
}
