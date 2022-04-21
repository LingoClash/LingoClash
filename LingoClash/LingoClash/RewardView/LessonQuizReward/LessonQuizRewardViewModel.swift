//
//  LessonQuizRewardViewModel.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 15/4/22.
//

import Combine
import PromiseKit
import UIKit

class LessonQuizRewardViewModel: RewardSystem {

    @Published var snackbarText: String?

    override func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizPassed(_:)),
                                               name: .lessonQuizPassed, object: nil)
    }

    @objc private func lessonQuizPassed(_ notification: Notification) {
        guard let dict = notification.userInfo,
              let starCount = dict["stars"] as? Int else {
            return
        }
        if starCount <= 0 {
            return
        }

        self.rewardLessonQuizPass(starCount: starCount)
    }

    private func rewardLessonQuizPass(starCount: Int) {
        firstly {
            getStarReward(amount: starCount, description: .lessonCompletion)
        }.done { currencyTransaction in
            self.presentReward(transaction: currencyTransaction)
            self.snackbarText = "You earned \(starCount) star(s) for completing a lesson!"
        }.done {
            self.rewardLearnLessonOneWeekStreak()
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }

    private func rewardLearnLessonOneWeekStreak() {
        StarAccountManager().getStarAccount()
        .done { starAccount in
            if  self.checkStreakRewardGiven(account: starAccount) ||
                !self.checkStreak(account: starAccount) {
                return
            }

            firstly {
                self.getStarReward(amount: 1, description: .lessonStreakAchievement)
            }.done { currencyTransaction in
                self.presentReward(transaction: currencyTransaction)
                self.snackbarText = "You earned a star for a 1 week learning streak! " +
                                    "Keep up the streak to earn more bonus stars!"
            }.catch { error in
                Logger.error(error.localizedDescription)
            }
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }

    private func checkStreak(account: CurrencyAccount<Star>) -> Bool {
        let sixDaysBefore = DateComponents(day: -6)
        let currDay = Calendar.current.startOfDay(for: Date())
        let startDate = Calendar.current.date(byAdding: sixDaysBefore, to: currDay)

        guard let startDate = startDate else {
            return false
        }

        let transactions = account.transactions.filter { transaction in
            transaction.createdAt >= startDate &&
            transaction.debitOrCredit == .debit &&
            transaction.description == .lessonCompletion
        }

        var streakDays = Array(repeating: false, count: 7)
        for transaction in transactions {
            let interval = transaction.createdAt - startDate
            guard let days = interval.day else {
                return false
            }

            if days >= 0 && days <= 6 {
                streakDays[days] = true
            }
        }

        return streakDays.allSatisfy { $0 }
    }

    private func checkStreakRewardGiven(account: CurrencyAccount<Star>) -> Bool {
        let currDay = Calendar.current.startOfDay(for: Date())
        let transactions = account.transactions.filter { transaction in
            transaction.createdAt >= currDay &&
            transaction.description == .lessonStreakAchievement
        }

        return !transactions.isEmpty
    }
}
