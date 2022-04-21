//
//  PKGameOverviewViewModelFromOutcome.swift
//  LingoClash
//
//  Created by Sherwin Poh on 4/4/22.
//

import Foundation

class PKGameOverviewViewModelFromOutcome: PKGameOverviewViewModel {
    var titleOutcome: String
    var descriptionOutcome: String
    var isBackgroundDark: Bool
    var didWin: Bool
    private let playerOutcome: PKGamePlayerOutcome
    private let playerOutcomes: [PKGamePlayerOutcome]
    var scores: [String]
    var names: [String]
    init(outcome: PKGameOutcome, currentPlayer: Profile) {
        guard let playerOutcome = outcome.playerOutcomes.first(where: { $0.profile == currentPlayer }) else {
            fatalError("Unable to get current player outcome")
        }
        self.playerOutcome = playerOutcome
        self.playerOutcomes = [playerOutcome] + outcome.playerOutcomes.filter({ $0.profile != currentPlayer })

        self.names = playerOutcomes.map { $0.profile.name }
        self.scores = playerOutcomes.map { $0.didForfeit ? "Forfeited": String($0.score) }

        switch playerOutcome.outcome {
        case .lose:
            self.didWin = false
            self.titleOutcome = "Loss"
            self.descriptionOutcome = "Better luck next time."
            self.isBackgroundDark = true
        case .win:
            self.didWin = true
            self.titleOutcome = "Victorious"
            self.descriptionOutcome = "Masterful!"
            self.isBackgroundDark = false
            NotificationCenter.default.post(name: .PKGameWon, object: nil, userInfo: nil)
        case .draw:
            self.didWin = false
            self.titleOutcome = "Draw"
            self.descriptionOutcome = "You have met your match."
            self.isBackgroundDark = true
        }
    }
}
