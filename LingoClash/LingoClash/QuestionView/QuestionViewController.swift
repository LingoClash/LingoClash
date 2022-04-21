//
//  QuestionViewController.swift
//  LingoClash
//
//  Created by Sherwin Poh on 20/3/22.
//

import UIKit

class QuestionViewController: UIViewController {
    typealias VM = QuestionViewModel
    var datasource: QuestionViewControllerDataSource?
    var delegate: QuestionViewControllerDelegate?
    var currentChildVC: QuestionLayoutViewController?
    var viewModel: VM? {
        didSet {
            fillUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }

    func reloadData() {
        setUpViewModel()
    }

    private func styleUI() {

    }

    private func fillUI() {
        guard isViewLoaded, let viewModel = viewModel else {
            return
        }
        guard let layoutViewModel = viewModel.questionLayoutViewModel else {
            return
        }
        loadQuestionLayoutViewController(belongingTo: layoutViewModel)
    }

    private func loadQuestionLayoutViewController(belongingTo questionLayoutViewModel: QuestionLayoutViewModel) {
        var viewController: QuestionLayoutViewController?
        switch questionLayoutViewModel {
        case let simpleOptionQuestionLayoutViewModel as SimpleOptionQuestionLayoutViewModel:
            let vc = SimpleOptionQuestionLayoutViewController.instantiateFromAppStoryboard(AppStoryboard.Question)
            vc.viewModel = simpleOptionQuestionLayoutViewModel
            viewController = vc
        case let twoDisjointSetOptionQuestionLayoutViewModel as TwoDisjointSetOptionQuestionLayoutViewModel:
            let vc = TwoDisjointSetOptionQuestionLayoutViewController.instantiateFromAppStoryboard(
                AppStoryboard.Question)
            vc.viewModel = twoDisjointSetOptionQuestionLayoutViewModel
            viewController = vc
        default:
            return
        }
        if let viewController = viewController {
            viewController.delegate = self
            loadQuestionLayoutViewController(viewController)
        }
    }

    private func loadQuestionLayoutViewController(_ newViewController: QuestionLayoutViewController) {
        let oldViewController = self.currentChildVC
        if let oldViewController = oldViewController {
            let oldFrame = oldViewController.view.frame
            let newStartingFrmae = CGRect(origin: oldFrame.origin.adding(vector: CGVector(dx: oldFrame.size.width, dy: 0)), size: oldFrame.size)
            oldViewController.willMove(toParent: nil)
            addChild(newViewController)
            view.addSubview(newViewController.view)
            
            newViewController.view.frame = newStartingFrmae
            self.transition(from: oldViewController, to: newViewController, duration: 0.5, animations: {
                newViewController.view.frame = oldViewController.view.frame
                oldViewController.view.alpha = 0
            }, completion: { finished in
                oldViewController.view.removeFromSuperview()
                oldViewController.removeFromParent()
                newViewController.didMove(toParent: self)
            })
            
            self.currentChildVC = newViewController
        } else {
            addChild(newViewController)
            view.addSubview(newViewController.view)
            setVCConstraints(newViewController)
            newViewController.didMove(toParent: self)

            oldViewController?.willMove(toParent: nil)
            oldViewController?.view.removeFromSuperview()
            oldViewController?.removeFromParent()

            self.currentChildVC = newViewController
        }
    }

    private func setVCConstraints(_ viewController: QuestionLayoutViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        viewController.view.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        viewController.view.leadingAnchor.constraint(
            equalTo: view.leadingAnchor, constant: 20).isActive = true
        viewController.view.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    private func setUpViewModel() {
        guard let vm = datasource?.setViewModel(self) else {
            return
        }
        self.viewModel = vm
    }
}

extension QuestionViewController: QuestionLayoutVCDelegate {
    func questionLayoutViewController(_: QuestionLayoutViewController, didAnswerCorrectly: Bool) {
        self.delegate?.questionViewController(self, didAnswerCorrectly: didAnswerCorrectly)
    }
}

protocol QuestionViewControllerDataSource {
    func setViewModel(_: QuestionViewController) -> QuestionViewModel?
}

protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ : QuestionViewController, didAnswerCorrectly: Bool)
}
