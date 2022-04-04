//
//  PKGameQuizViewModelFromPKGame.swift
//  LingoClash
//
//  Created by Sherwin Poh on 4/4/22.
//

class PKGameQuizViewModelFromPKGame: PKGameQuizViewModel {
    var moveUpdateDelegate: PKGameMoveUpdateDelegate
    let currentPlayerProfile: Profile
    let pkGame: PKGame
    let pkGameEngine: PKGameEngine
    var questionViewModel: Dynamic<QuestionViewModel?> = Dynamic(nil)
    var gameOverviewViewModel: Dynamic<PKGameOverviewViewModel?> = Dynamic(nil)
    var playerNames: [String]
    private var players: [Profile]
    var scores: Dynamic<[Int]>
    init(game: PKGame, currentPlayerProfile: Profile) {
        self.pkGame = game
        self.moveUpdateDelegate = FirebasePKGameMoveUpdater(game: game)
        self.currentPlayerProfile = currentPlayerProfile
        
        self.playerNames = game.players.map({ $0.name.capitalized })
        self.scores = Dynamic(game.players.map( { _ in
            return 0
        } ))
        self.players = game.players
        
        self.pkGameEngine = PKGameEngine(game: game)
        
        self.pkGameEngine.renderer = self
        self.moveUpdateDelegate.moveListener = self

    }
    
    func questionDidComplete(isCorrect: Bool) {
        let move = pkGameEngine.addMove(isCorrect: isCorrect, playerProfile: currentPlayerProfile)
        guard let move = move else {
            return
        }
        
        self.moveUpdateDelegate.didMove(move: move)
    }
}

extension PKGameQuizViewModelFromPKGame {
    func didChangeQuestion(currQuestion: Question) {
        self.questionViewModel.value = QuestionViewModelFromQuestion(question: currQuestion)
    }
    
    func didCompleteGame(gameOutcome: PKGameOutcome) {
        self.gameOverviewViewModel.value = PKGameOverviewViewModelFromOutcome(outcome: gameOutcome)
    }
    
    func didAddMove(_ move: PKGameMove) {
    }
    
    func didIncrementScore(newScore: Int, change: Int, player: Profile) {
        var newScores = self.scores.value
        guard let index = players.firstIndex(of: player) else {
            assert(false)
            return
        }
        newScores[index] = newScore
        self.scores.value = newScores
    }
}


extension PKGameQuizViewModelFromPKGame {
    func didMove(_ move: PKGameMove) {
        pkGameEngine.addMove(move)
    }
}
