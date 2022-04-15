//
//  Question.swift
//  LingoClash
//
//  Created by Sherwin Poh on 20/3/22.
//

protocol Question {
    static var vocabsTestedCount: Int { get }
    var vocabsTested: Set<Vocab> { get }
    func isCorrect(response: Any) -> Bool
}