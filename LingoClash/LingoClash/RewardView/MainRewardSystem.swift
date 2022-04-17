//
//  MainRewardSystem.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 15/4/22.
//

class MainRewardSystem {
    private static let lessonQuizRewardSytemView: RewardSystemView = LessonQuizRewardView()
    private static let pkGameRewardSystemView: RewardSystemView = PKGameRewardView()

    private static var rewardSystems: [RewardSystemView] {
        [lessonQuizRewardSytemView]
    }

    static func setUp() {
        for rewardSystem in rewardSystems {
            rewardSystem.setUp()
        }
    }
}
