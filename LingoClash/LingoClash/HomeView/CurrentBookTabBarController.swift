//
//  CurrentBookViewController.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 22/3/22.
//

import UIKit
import Combine

class CurrentBookTabBarController: UITabBarController {

    var viewModel: HomeViewModel?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.stopRefresh()
    }

    func setUpBinders() {
        let currentBookViewIndex = 0
        let noBookViewIndex = 1

        viewModel?.$currentBook.sink {[weak self] book in
            if book != nil {
                self?.selectedIndex = currentBookViewIndex
            } else {
                self?.selectedIndex = noBookViewIndex
            }
        }.store(in: &cancellables)

        viewModel?.$isRefreshing.sink {[weak self] isRefreshing in
            if isRefreshing {
                self?.parent?.showSpinner()
            } else {
                self?.parent?.removeSpinner()
            }
        }.store(in: &cancellables)
    }
}
