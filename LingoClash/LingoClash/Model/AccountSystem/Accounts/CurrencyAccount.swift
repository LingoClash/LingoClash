//
//  CurrencyAccount.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 3/4/22.
//

class CurrencyAccount<T: Currency>: Account {
    var balance: Int
    var owner: AccountOwner
    var transactions = [CurrencyTransaction<T>]()
    
    init(owner: AccountOwner, balance: Int) {
        self.owner = owner
        self.balance = balance
    }
    
    func createTransaction(amount: Int, description: String) -> CurrencyTransaction<T>? {
        guard amount != 0 else {
            return nil
        }
        let action: DebitOrCredit = amount > 0 ? .debit : .credit
        let transaction = CurrencyTransaction<T>(debitOrCredit: action, amount: abs(amount), account: self)
        return transaction
    }
    
    func addTransaction(_ transaction: CurrencyTransaction<T>) {
        self.transactions.append(transaction)
    }
}
