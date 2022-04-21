//
//  PronounciationOptionQuestionConstructor.swift
//  LingoClash
//
//  Created by Sherwin Poh on 21/4/22.
//

struct PronounciationOptionQuestionConstructor: QuestionContructor {
    let vocabsTestedCount = DefinitionOptionQuestion.vocabsTestedCount
    let otherVocabsCount = DefinitionOptionQuestion.optionsCount - DefinitionOptionQuestion.vocabsTestedCount

    func constructQuestion(vocabsTested: Set<Vocab>, otherVocabs: Set<Vocab>) -> Question? {
        guard vocabsTested.count == vocabsTestedCount,
              otherVocabs.count == otherVocabsCount,
              let correctVocab = vocabsTested.first else {
            return nil
        }

        let vocabs = vocabsTested.union(otherVocabs)
        let options = vocabs.map { $0.word }.shuffled()
        return DefinitionOptionQuestion(
            context: correctVocab.pronunciationText,
            options: options,
            answer: correctVocab.word,
            vocabsTested: vocabsTested)
    }
}
