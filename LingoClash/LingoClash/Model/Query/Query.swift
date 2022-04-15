//
//  Query.swift
//  LingoClash
//
//  Created by kevin chua on 3/4/22.
//

import Foundation


// A Query is more general than a Question.
// It just has the context (Question to be asked)
// and the answer in string format.
// isCorrect etc is addressed in Answerable.

protocol Query {
//    var prompt: String { get }
//    var answer: String { get }
    // Gives the "ordering" in this sequence of queries
    // magnitude not required for questions, but is required for revision
//    var magnitude: Int { get }
    
    var context: String { get }
    
    // TODO: replace this with an actual Answer struct
    var answerToString: String { get }
}
