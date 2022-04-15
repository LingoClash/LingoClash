//
//  PKGameEngine.swift
//  LingoClash
//
//  Created by Sherwin Poh on 4/4/22.
//
import Foundation

class PKGameEngine {
    static let maxPointsPerQuestion = 100.0
    static let maxTimePerQuestion = 15.0
    var timeSinceStartOfCurrentQuestion: Date?
    var renderer: PKGameRenderer? {
        didSet {
            loadNextQuestion()
        }
    }
    let questions: [Question]
    private var currQuestionIndex: Int = -1
    var moves: [PKGameMove]
    var players: [Profile]
    var scores: [ Profile: Int ]
    var currentQuestion: Question {
        questions[currQuestionIndex]
    }
    
    init(game: PKGame) {
        self.questions = game.questions
        self.moves = []
        self.players = game.players
        self.scores = [:]
        for player in players {
            scores[player] = 0
        }
    }
    
    // Returns true if player successfully forfeitted game
    func forfeitGame(player: Profile) -> Bool {
        renderer?.didAccountForForfeit(player: player)
        return true
    }
    
    func addMove(isCorrect: Bool, playerProfile: Profile) -> PKGameMove? {
        guard players.contains(where: { $0 == playerProfile }) else {
            return nil
        }
        
        guard let timeTaken = getTimeTaken() else {
            return nil
        }
        let move = PKGameMove(question: currentQuestion, player: playerProfile, isCorrect: isCorrect, timeTaken: timeTaken)
        return addMove(move)
    }
        
    func addMove(_ move: PKGameMove) -> PKGameMove? {
        guard isMoveValid(move) else {
            return nil
        }
        moves.append(move)
        renderer?.didAddMove(move)
        
        updateScore(for: move)
        
        if shouldLoadNextQuestion() {
            loadNextQuestion()
        }
        return move
    }
    
    func updateScore(for move: PKGameMove) {
        if move.isCorrect {
            let player = move.player
            let scoreIncrement = Int((PKGameEngine.maxPointsPerQuestion * (max((PKGameEngine.maxTimePerQuestion - move.timeTaken), 0.0) / PKGameEngine.maxTimePerQuestion)).rounded())
            guard let oldScore = scores[player] else {
                assert(false)
                return
            }
            let newScore = oldScore + scoreIncrement
            scores[player] = newScore
            renderer?.didIncrementScore(newScore: newScore, change: scoreIncrement, player: move.player)
        }
        
    }
    
    func shouldLoadNextQuestion() -> Bool {
        var playersThatAnswered = Set<Profile>()
        moves.forEach( { move in
            if move.question.isEqual(to: currentQuestion) {
                playersThatAnswered.insert(move.player)
            }
        })
        let hasAllPlayersAnsweredQuestion = playersThatAnswered.isSuperset(of: Set(players))
        return hasAllPlayersAnsweredQuestion
    }
    
    func isMoveValid(_ move: PKGameMove) -> Bool {
        let hasRepeatedExistingMoves = self.moves.contains(where: {
            $0.isRepeated(with: move)
        })
        return !hasRepeatedExistingMoves
    }
    
    private func getTimeTaken() -> Double? {
        guard let timeSinceStartOfCurrentQuestion = timeSinceStartOfCurrentQuestion else {
            assert(false)
            return nil
        }
        let currTime = Date.now
        let timeElasped = currTime.timeIntervalSince(timeSinceStartOfCurrentQuestion)
        return timeElasped
    }
    
    private func loadNextQuestion() {
        guard !isGameComplete() else {
            return gameDidComplete()
        }
        
        self.timeSinceStartOfCurrentQuestion = Date.now
        self.currQuestionIndex += 1
        renderer?.didChangeQuestion(currQuestion: currentQuestion)
    }
    
    private func isGameComplete() -> Bool {
//        return true
//        return currQuestionIndex == 1
        return currQuestionIndex >= self.questions.count - 1
    }
    
    private func gameDidComplete() {
        guard isGameComplete() else {
            return
        }
        
        guard let gameOutcome = generateGameOutcome() else {
            assert(false)
            return
        }
        
        renderer?.didCompleteGame(gameOutcome: gameOutcome)
    }
    
    private func generateGameOutcome() -> PKGameOutcome? {
        guard isGameComplete() else {
            return nil
        }
        let questionOutcomes = self.questions.map({ question -> [Profile: Bool] in
            let moves = moves.filter({ $0.question.isEqual(to: question)})
            var questionOutcome: [Profile: Bool] = [:]
            for move in moves {
                questionOutcome[move.player] = move.isCorrect
            }
            return questionOutcome
        })
        var highest: Int = 0
        var highestPlayers = [Profile]()
        for (profile, score) in self.scores {
            if score > highest {
                highestPlayers = [profile]
                highest = score
            } else if score == highest {
                highestPlayers.append(profile)
            }
        }
        let playerOutcomes: [Profile: PKGamePlayerOutcome] = self.scores.mapValues { score in
            if score == highest {
                if highestPlayers.count > 1 {
                    return PKGamePlayerOutcome.draw
                } else {
                    return PKGamePlayerOutcome.win
                }
            } else {
                return PKGamePlayerOutcome.lose
            }
        }
        return PKGameOutcome(questions: self.questions, questionOutcomes: questionOutcomes, scores: self.scores, playerOutcomes: playerOutcomes)
    }
}
