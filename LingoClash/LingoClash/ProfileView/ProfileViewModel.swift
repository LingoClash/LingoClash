//
//  ProfileViewModel.swift
//  LingoClash
//
//  Created by Kyle キラ on 14/3/22.
//

import PromiseKit
import Combine

final class ProfileViewModel {

    @Published var isRefreshing = false
    @Published var error: String?
    @Published var name: String?
    @Published var email: String?
    @Published var totalStars: String?
    @Published var starsToday: String?
    @Published var starsGoal: String?
    @Published var starsGoalProgress: Float?
    @Published var bio: String?
    @Published var vocabsLearnt: String?
    @Published var pkWinningRate: String?
    @Published var rankingByTotalStars: String?
    @Published var alertContent: AlertContent?
    @Published var dateToStars: [Date:Int] = [:]

    private let authProvider: AuthProvider
    private let profileManager = ProfileManager()

    init(authProvider: AuthProvider = AppConfigs.API.authProvider) {
        self.authProvider = authProvider
    }

    func signOut() {
        firstly {
            authProvider.logout()
        }.done {
            self.error = nil
            self.alertContent = AlertContent(title: "", message: "Are you sure you want to log out?")
        }.catch { error in
            self.error = error.localizedDescription
        }
    }

    func refresh() {
        self.isRefreshing = true
        firstly {
            profileManager.getCurrentProfile()
        }.done { profile in
            self.name = profile.name
            self.email = profile.email
            self.starsToday = String(profile.starsToday)
            self.totalStars = String(profile.stars)
            self.starsGoal = String(profile.starsGoal)
            self.starsGoalProgress = min(
                Float(profile.starsToday) / Float(profile.starsGoal), 1)
            self.bio = profile.bio
            self.vocabsLearnt = String(profile.vocabsLearnt)
            self.pkWinningRate = String(format: "%.2f", profile.pkWinningRate)
            self.rankingByTotalStars = String(profile.rankingByTotalStars)
        }.then {
            StarAccountManager().getStarAccount()
        }.done { starAccount in
            for transaction in starAccount.transactions {
                let date = Calendar.current.startOfDay(for: transaction.createdAt)
                
                if let stars = self.dateToStars[date] {
                    if transaction.amount > stars {
                        self.dateToStars[date] = stars + transaction.amount
                    }
                } else {
                    self.dateToStars[date] = transaction.amount
                }
            }
            self.isRefreshing = false
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
    
    func stopRefresh() {
        self.isRefreshing = false
    }
}
