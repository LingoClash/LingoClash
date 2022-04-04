//
//  RevisionScopeFactory.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

import Foundation

/// Initialise this using a set of vocabs. Converts it into a set of revision vocabs with no date and time
/// 
struct RevisionScopeFactory {
    var scope: Set<RevisionVocab>
    
//    init(vocabSet: Set<Vocab>) {
//        for vocab in vocabSet {
//            let revisionVocab = RevisionVocab(difficultyParameter: Difficulty(amount: 0), vocab: vocab)
//            scope.insert(revisionVocab)
//        }
//    }
    
//    private mutating func getTestedVocabs(count: Int) -> Set<Vocab> {
//        // get and pop from compulsory scope, rest get randomly from scope
//        guard !compulsoryScope.isEmpty else {
//            return getOtherVocabs(count: count)
//        }
//        // Pops from compulsory scope, returns, if compulsory scope is empty,
//        let countFromCompulsory = min(count, compulsoryScope.count)
//        let leftover = count - countFromCompulsory
//        let compulsoryVocabs = Set(compulsoryScope.suffix(countFromCompulsory))
//        compulsoryScope.removeLast(countFromCompulsory)
//        if leftover != 0 {
//            let otherVocabs = getOtherVocabs(count: leftover, notIn: compulsoryVocabs)
//            return compulsoryVocabs.union(otherVocabs)
//        } else {
//            return compulsoryVocabs
//        }
//    }
    
    
    
//    mutating func getScope(for questionConstructor: QuestionContructor) -> (tested: Set<Vocab>, others: Set<Vocab>) {
//        let testedVocabs = getTestedVocabs(count: questionConstructor.vocabsTestedCount)
//        let otherVocabs = getOtherVocabs(count: questionConstructor.otherVocabsCount, notIn: testedVocabs)
//        return (tested: testedVocabs, others: otherVocabs)
//    }
//
//    private func getOtherVocabs(count: Int, notIn excludeVocabs: Set<Vocab> = Set()) -> Set<Vocab> {
//        // get vocabs randomly from scope not in excludedVocabs
//        guard count >= 0 else {
//            return Set()
//        }
//        let vocabs = scope.subtracting(excludeVocabs)
//        return Set(vocabs.randomSample(count: count))
//    }
//

}
