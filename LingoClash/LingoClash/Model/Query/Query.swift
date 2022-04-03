//
//  Query.swift
//  LingoClash
//
//  Created by kevin chua on 3/4/22.
//

import Foundation

protocol Query {
    var prompt: String { get }
    var answer: String { get }
    // Gives the "ordering" in this sequence of queries
    var magnitude: Int { get }
}
