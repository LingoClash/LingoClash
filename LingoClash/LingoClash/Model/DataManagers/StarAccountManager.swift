//
//  StarAccountManager.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 12/4/22.
//

import PromiseKit

class StarAccountManager: DataManager<StarAccountData> {
    
    init() {
        super.init(resource: "star_accounts")
    }
    
    func getStarAccount() -> Promise<CurrencyAccount<Star>> {
        var profile: Profile?
        var starAccountData: StarAccountData?
        var starAccount: CurrencyAccount<Star>?
        
        return firstly {
            firstly {
                ProfileManager().getCurrentProfile()
            }.done { profileData in
                profile = profileData
            }
        }.then { () -> Promise<Void> in
            guard let profile = profile else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }

            return firstly {
                self.getOneReference(target: "owner_id", id: profile.id)
            }.done { currStarAccountData in
                guard let currStarAccountData = currStarAccountData else {
                    return
                }

                starAccountData = currStarAccountData
                starAccount = CurrencyAccount<Star>.init(id: currStarAccountData.id, owner: profile, balance: currStarAccountData.balance)
            }
        }.then{ () -> Promise<Void> in
            guard let starAccount = starAccount, let starAccountData = starAccountData else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }

            return firstly {
                StarTransactionManager().getStarTransactions(accountId: starAccountData.id, account: starAccount)
            }.done { starTransactions in
                starAccount.transactions = starTransactions
            }
        }.compactMap {
            guard let starAccount = starAccount else {
                return nil
            }
            return starAccount
        }
    }
    
    func updateStarAccount(account: CurrencyAccount<Star>, newTransaction: CurrencyTransaction<Star>) -> Promise<CurrencyAccount<Star>> {
        var updatedAccountData: StarAccountData?
        var newTransactionData: StarTransactionData?
        var updatedAccount: CurrencyAccount<Star>?

        return firstly {
            let accountData = StarAccountData(id: account.id, owner_id: account.owner.id, balance: account.balance)
            return self.update(id: account.id, to: accountData).done { starAccountData in
                updatedAccountData = starAccountData
            }
        }.then { () -> Promise<Void> in
            guard let _ = updatedAccountData else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }

            let transactionData = StarTransactionData(id: "", account_id: account.id, amount: newTransaction.amount,
                                                      createdAt: newTransaction.createdAt, debitOrCredit: newTransaction.debitOrCredit,
                                                      description: newTransaction.description)
            return firstly {
                StarTransactionManager().create(newRecord: transactionData)
            }.done { starTransactionData in
                newTransactionData = starTransactionData
            }
        }.then { () -> Promise<Void> in
            return firstly {
                self.getStarAccount()
            }.done { starAccount in
                updatedAccount = starAccount
            }
        }.compactMap {
            guard let updatedAccount = updatedAccount else {
                return nil
            }
            return updatedAccount
        }
    }
}
