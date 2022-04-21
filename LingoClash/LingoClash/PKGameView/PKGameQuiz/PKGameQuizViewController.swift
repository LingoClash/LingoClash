//
//  PKGameQuizViewController.swift
//  LingoClash
//
//  Created by Sherwin Poh on 3/4/22.
//

import UIKit
import simd

class PKGameQuizViewController: UIViewController {
    enum Segue {
        static let toQuestionViewController = "segueFromPKGameQuizToQuestionVC"
        static let toOverviewViewController = "segueFromPKGameQuizToOverviewVC"
        static let unwindFromPKGameQuizToHome = "unwindFromPKGameQuizToHome"
    }
    typealias VM = PKGameQuizViewModel
    weak var questionViewController: QuestionViewController?

    var viewModel: VM? {
        didSet {
            fillUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
        fillUI()
        AudioPlayer.playPKGameBackgroundMusic()
    }
    
    @IBOutlet private var playerNames: [UILabel]!
    @IBOutlet private var playerScores: [UILabel]!

    func styleUI() {

    }

    @IBOutlet weak var headerView: UIView!
    @IBAction private func forfeit(_ sender: Any) {
        Logger.info("did click forfeit")
        let forfeitConfirmation = UIAlertController(
            title: "Forfeit",
            message: "Forfeit in cowardice? Are you sure?",
            preferredStyle: .alert)

         // Create OK button with action handler
         let proceed = UIAlertAction(title: "A Coward I am.", style: .default, handler: { _ -> Void in
             self.viewModel?.forfeitGame()
          })
        let cancel = UIAlertAction(title: "Stay and fight!", style: .cancel, handler: { _ -> Void in
            })

        forfeitConfirmation.addAction(proceed)
        forfeitConfirmation.addAction(cancel)
        self.present(forfeitConfirmation, animated: true, completion: nil)

    }

    @IBOutlet weak var balanceProgressBar: UIProgressView!
    func fillUI() {
        guard isViewLoaded, let viewModel = viewModel else {
            return
        }
        viewModel.playerNames.enumerated().forEach { index, name in
            playerNames[index].text = name
        }
        
        viewModel.scores.enumerated().forEach { [weak self] index, score in
            score.bindAndFire { score in
                self?.playerScores[index].text = String(score)
            }
        }
        
        viewModel.scoresChange.enumerated().forEach { [weak self] index, change in
            change.bindAndFire { change in
                self?.popupScoreIncrement(playerIndex: index, increment: change)
            }
        }
        
    
        viewModel.questionViewModel.bindAndFire { [weak self] _ -> Void in
            self?.questionViewController?.reloadData()
        }
        
        viewModel.balance.bindAndFire { [weak self] in
            self?.balanceProgressBar.setProgress($0[0], animated: true)
        }


        viewModel.gameOverviewViewModel.bindAndFire { [weak self] in
            self?.navigateAfterQuizCompleted(vm: $0)
        }
    }
    
    func popupScoreIncrement(playerIndex: Int, increment: Int) {
        guard increment != 0 else {
            return
        }
        let scoreLabel = self.playerScores[playerIndex]
        let scoreIncrement = UILabel(frame: scoreLabel.frame)
        scoreIncrement.text = String(increment)
        scoreIncrement.textColor = Theme.current.primaryText
        scoreIncrement.font = UIFont(name: "SF Pro", size: 30)
        self.headerView.addSubview(scoreIncrement)
        let animations = [AnimationType.vector(CGVector(dx: 0, dy: 50))]
        scoreIncrement.animate(animations: animations, initialAlpha: 1, finalAlpha: 0, delay: 0.5, duration: 1, options: UIView.AnimationOptions.curveEaseInOut, completion: {
            scoreIncrement.removeFromSuperview()
        })
    }


    func navigateAfterQuizCompleted(vm: PKGameOverviewViewModel?) {
        guard vm != nil else {
            return
        }
        performSegue(withIdentifier: Segue.toOverviewViewController, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toQuestionViewController {
            guard let questionViewController = segue.destination as? QuestionViewController else {
                return
            }
            self.questionViewController = questionViewController
            questionViewController.datasource = self
            questionViewController.delegate = self

        } else if segue.identifier == Segue.toOverviewViewController {
            guard let gameOverviewViewModel = viewModel?.gameOverviewViewModel.value,
                  let outcomeViewController = segue.destination as? PKGameOverviewViewController else {
                return
            }
            outcomeViewController.viewModel = gameOverviewViewModel
        }
    }
}

extension PKGameQuizViewController: QuestionViewControllerDataSource {
    func setViewModel(_: QuestionViewController) -> QuestionViewModel? {
        viewModel?.questionViewModel.value
    }
}

extension PKGameQuizViewController: QuestionViewControllerDelegate {
    func questionViewController(_: QuestionViewController, didAnswerCorrectly: Bool) {
        viewModel?.questionDidComplete(isCorrect: didAnswerCorrectly)
        
    }

}
