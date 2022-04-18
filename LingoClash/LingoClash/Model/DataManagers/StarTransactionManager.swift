//
//  StarTransactionManager.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 12/4/22.
//
import PromiseKit

class StarTransactionManager: DataManager<StarTransactionData> {

    init() {
        super.init(resource: DataManagerResources.starTransactions)
    }
    
    func getStarTransactionData() -> Promise<[StarTransactionData]> {
                
        return firstly {
            ProfileManager().getCurrentProfileData()
        }.then { profileData -> Promise<StarAccountData?> in
            StarAccountManager().getOneReference(target: "owner_id", id: profileData.id)
        }.then { starAccountData -> Promise<[StarTransactionData]> in
            guard let starAccountData = starAccountData else {
                return Promise.reject(reason: DataManagerError.dataNotFound)
            }
            
            return self.getManyReference(target: "account_id", id: starAccountData.id)
        }
    }

    func getStarTransactions(accountId: Identifier, account: CurrencyAccount<Star>)
    -> Promise<[CurrencyTransaction<Star>]> {

        var starTransactions = [StarTransactionData]()

        return firstly {
            firstly {
                self.getManyReference(target: "account_id", id: accountId)
            }.done { starTransactionData in
                starTransactions = starTransactionData
            }
        }.compactMap {
            starTransactions.map { starTransaction in
                CurrencyTransaction<Star>(id: starTransaction.id,
                                          debitOrCredit: starTransaction.debitOrCredit,
                                          amount: starTransaction.amount,
                                          account: account,
                                          description: starTransaction.description,
                                          createdAt: starTransaction.createdAt)
            }
        }
    }
}
