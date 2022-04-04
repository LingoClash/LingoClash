//
//  RewardSystem.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 1/4/22.
//

class RewardSystem {
    func generateReward(fromResult result: LessonQuizResult) -> Reward? {
        // TODO: retrieve user star account
        let user = User(id: "1", book_id: "1", user_id: "af75EVg2WOVarSw6NHL9P77gBXq2")
        let account = CurrencyAccount<Star>.init(owner: user, balance: 1)
        let transaction = account.createTransaction(amount: result.starsObtained, description: "Completed \(result.lessonName)")
        
        guard let transaction = transaction else {
            return nil
        }

        let reward = Reward(transactions: [transaction])
        return reward
        
        // TODO: check if user completed lessons 5 days in a row, generate more rewards if so
        
    }
}
