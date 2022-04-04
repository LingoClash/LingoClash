//
//  ItemAccount.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 3/4/22.
//

class ItemAccount<T: Item>: Account {
    var items: [T]
    var owner: AccountOwner
    var transactions = [ItemTransaction<T>]()
    
    init(owner: AccountOwner, items: [T]) {
        self.owner = owner
        self.items = items
    }
    
    func createTransaction(items: [T], debitOrCredit: DebitOrCredit, description: String) -> ItemTransaction<T>? {
        guard !items.isEmpty else {
            return nil
        }
        
        let transaction = ItemTransaction<T>(debitOrCredit: debitOrCredit, items: items, account: self)
        return transaction
        self.transactions.append(transaction)
    }
    
    func addTransaction(_ transaction: ItemTransaction<T>) {
        self.transactions.append(transaction)
    }
}
