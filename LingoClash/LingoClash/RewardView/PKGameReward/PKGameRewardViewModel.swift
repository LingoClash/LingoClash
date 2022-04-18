//
//  PKGameRewardViewModel.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 15/4/22.
//

import Foundation
import PromiseKit

class PKGameRewardViewModel: RewardSystem {
    @Published var snackbarText: String?

    override func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(pkGameWon(_:)), name: .PKGameWon, object: nil)
    }

    @objc func pkGameWon(_ notification: Notification) {
        firstly {
            getStarReward(amount: 1, description: .pkGameWon)
        }.done { currencyTransaction in
            self.presentReward(transaction: currencyTransaction)
            self.snackbarText = "You earned a star for winning a PK!"
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
}
