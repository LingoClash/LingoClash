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
