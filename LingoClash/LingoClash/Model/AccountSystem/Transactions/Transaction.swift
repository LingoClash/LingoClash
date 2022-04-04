//
//  Transaction.swift
//  LingoClash
//
//  Created by Sherwin Poh on 19/3/22.
//

import Foundation

protocol Transaction {
    var debitOrCredit: DebitOrCredit { get set }
    var createdAt: Date { get set }
    var description: String { get set }
    func execute()
}
