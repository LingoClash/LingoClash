//
//  StarTransactionManager.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 12/4/22.
//

import PromiseKit

class StarTransactionManager: DataManager<StarTransactionData> {
    
    init() {
        super.init(resource: "star_transactions")
    }
    
    func getStarTransactions(accountId: Identifier, account: CurrencyAccount<Star>) -> Promise<[CurrencyTransaction<Star>]> {
        var starTransactions = [StarTransactionData]()
        
        return firstly {
            firstly {
                self.getManyReference(target: "account_id", id: accountId)
            }.done { starTransactionData in
                starTransactions = starTransactionData
            }
        }.compactMap {
            return starTransactions.map { starTransaction in
                CurrencyTransaction<Star>.init(debitOrCredit: starTransaction.debitOrCredit, amount: starTransaction.amount, account: account, createdAt: starTransaction.createdAt, description: starTransaction.description)
            }
        }
    }
}
