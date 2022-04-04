//
//  CurrencyTransaction.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 3/4/22.
//

import Foundation

class CurrencyTransaction<T: Currency>: Transaction {
    var debitOrCredit: DebitOrCredit
    var amount: Int
    var account: CurrencyAccount<T>
    var createdAt: Date
    var description: String
    
    init(debitOrCredit: DebitOrCredit, amount: Int, account: CurrencyAccount<T>, createdAt: Date = Date(), description: String = "") {
        self.debitOrCredit = debitOrCredit
        self.amount = amount
        self.account = account
        self.createdAt = createdAt
        self.description = description
    }
    
    func execute() {
        if debitOrCredit == .debit {
            account.balance += amount
        } else {
            if account.balance - amount < 0 {
                return
            }
            account.balance -= amount
        }
        account.addTransaction(self)
        
        // TODO: Save to db
    }
}
