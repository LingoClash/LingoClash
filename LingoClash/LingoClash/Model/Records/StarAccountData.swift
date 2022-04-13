//
//  StarAccountData.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 12/4/22.
//

import Foundation

struct StarAccountData {
    var id: Identifier
    let owner_id: Identifier
    let balance: Int
}

extension StarAccountData: Record {}

struct StarTransactionData {
    var id: Identifier
    let account_id: Identifier
    let amount: Int
    let createdAt: Date
    let debitOrCredit: DebitOrCredit
    let description: String
}

extension StarTransactionData: Record {}
