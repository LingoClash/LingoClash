//
//  PKGameQuizViewModelFromPKGame.swift
//  LingoClash
//
//  Created by Sherwin Poh on 4/4/22.
//

class PKGameQuizViewModelFromPKGame: PKGameQuizViewModel {
    var gameUpdateDelegate: PKGameUpdateDelegate
    let currentPlayerProfile: Profile
    let pkGame: PKGame
    let pkGameEngine: PKGameEngine
    var questionViewModel: Dynamic<QuestionViewModel?> = Dynamic(nil)
    var gameOverviewViewModel: Dynamic<PKGameOverviewViewModel?> = Dynamic(nil)
    var playerNames: [String]
    private var players: [Profile]
    var scores: [Dynamic<Int>]
    var scoresChange: [Dynamic<Int>]
    var balance: Dynamic<[Float]>
    init(game: PKGame, currentPlayerProfile: Profile) {
        self.pkGame = game
        self.gameUpdateDelegate = FirebasePKGameUpdater(game: game)
        self.currentPlayerProfile = currentPlayerProfile
        self.players = [currentPlayerProfile] + game.players.filter { $0 != currentPlayerProfile }
        self.playerNames = self.players.map({ $0.name.capitalized })
        self.scores = self.players.map({ _ in
            Dynamic(0)
        })
        self.scoresChange = self.players.map { _ in
            Dynamic(0)
        }
        self.pkGameEngine = PKGameEngine(game: game)
        let playerCount = self.players.count
        self.balance = Dynamic(self.players.map { _ in
            1.0 / Float(playerCount)
        })

        self.pkGameEngine.renderer = self
        self.gameUpdateDelegate.gameUpdateListener = self
    }

    func questionDidComplete(isCorrect: Bool) {
        let move = pkGameEngine.addMove(isCorrect: isCorrect, playerProfile: currentPlayerProfile)
        guard let move = move else {
            return
        }

        self.gameUpdateDelegate.didMove(move: move)
    }

    func forfeitGame() {
        let didSucessfullyForfeit = pkGameEngine.forfeitGame(player: currentPlayerProfile)
        guard didSucessfullyForfeit else {
            Logger.info("Unable to forfeit game.")
            // TODO: Tell user this failure
            return
        }

        gameUpdateDelegate.didForfeit(player: currentPlayerProfile)
    }
}

// MARK: PKGameRenderer methods
extension PKGameQuizViewModelFromPKGame {
    func didChangeQuestion(currQuestion: Question) {
        self.questionViewModel.value = QuestionViewModelFromQuestion(question: currQuestion)
    }

    func didCompleteGame(gameOutcome: PKGameOutcome) {
        guard let currPlayerOutcome = gameOutcome.playerOutcomes.first(
            where: { $0.profile == currentPlayerProfile }) else {
            Logger.info("current player outcome not found.")
            assert(false)
            return
        }
        self.gameUpdateDelegate.didCompleteGame(outcome: currPlayerOutcome)
        self.gameOverviewViewModel.value = PKGameOverviewViewModelFromOutcome(
            outcome: gameOutcome,
            currentPlayer: currentPlayerProfile)
        
    }

    func didAddMove(_ move: PKGameMove) {
    }

    func didIncrementScore(newScore: Int, change: Int, player: Profile) {
        guard let index = players.firstIndex(of: player) else {
            assert(false)
            return
        }
        self.scores[index].value = newScore
        self.scoresChange[index].value = change
        updateBalance()
    }
    
    private func updateBalance() {
        let total = self.scores.reduce(0, { $0 + $1.value })
        guard total != 0 else {
            self.balance.value = self.players.map { _ in
                1.0 / Float(self.players.count)
            }
            return
        }
        self.balance.value = self.scores.map { Float($0.value) / Float(total) }
    }

    func didAccountForForfeit(player: Profile) {
        // TODO: Add some notif that a person has forfeitted
        Logger.info("renderer update forfeit.")
    }
}

// MARK: PKGameUpdateListener
extension PKGameQuizViewModelFromPKGame {
    func didMove(_ move: PKGameMove) {
        _ = pkGameEngine.addMove(move)
    }

    func didForfeit(player: Profile) {
        _ = pkGameEngine.forfeitGame(player: player)
        Logger.info("renderer update forfeit.")
    }
}
