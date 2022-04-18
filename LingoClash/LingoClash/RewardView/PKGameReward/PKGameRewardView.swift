//
//  PKGameRewardView.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 17/4/22.
//

import Combine
import UIKit

class PKGameRewardView: RewardSystemView {

    private let viewModel = PKGameRewardViewModel()
    private var cancellables: Set<AnyCancellable> = []

    func setUp() {
        viewModel.setUpObservers()
        setUpBinders()
    }

    private func setUpBinders() {
        viewModel.$snackbarText.sink { snackBarText in
            if let snackBarText = snackBarText {
                SnackbarUtilities.showSnackbar(type: .info, text: snackBarText)
            }
        }.store(in: &cancellables)
    }
}
