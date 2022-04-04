//
//  DisjointSetOptionQuestion.swift
//  LingoClash
//
//  Created by Sherwin Poh on 20/3/22.
//

protocol TwoDisjointSetOptionQuestion: Question {
    var prompt: String { get }
    var options: [[String]] { get }
    var answer: Set<[String]> { get }
}
