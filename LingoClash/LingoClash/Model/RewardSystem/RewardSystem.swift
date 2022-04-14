//
//  RewardSystem.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 1/4/22.
//

import Foundation

class NotificationSystem {
    private static let lessonQuizRewardSytem: NotificationObserver = LessonQuizRewardSystem()
    private static let pkGameRewardSystem: NotificationObserver = PKGameRewardSystem()
    
    private static var notificationObservers: [NotificationObserver] {
        [lessonQuizRewardSytem, pkGameRewardSystem]
    }

    static func setUpObservers() {
        for observer in notificationObservers {
            observer.setUpObservers()
        }
    }
}

protocol NotificationObserver {
    func setUpObservers()
}

class LessonQuizRewardSystem: NotificationObserver {
    func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizCompleted(_:)), name: .lessonQuizPassed, object: nil)
    }
    
    @objc func lessonQuizCompleted(_ notification: Notification) {
        print("hello here")
//        print(notification.object as? [String: Any] ?? [:])
    }
}

class PKGameRewardSystem: NotificationObserver {
    func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizCompleted(_:)), name: .PKGameWon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizCompleted(_:)), name: .PKGameLost, object: nil)
    }
    
    @objc func lessonQuizCompleted(_ notification: Notification) {
        print("hello")
//        print(notification.object as? [String: Any] ?? [:])
    }
}

extension Notification.Name {
    static var lessonQuizPassed: Notification.Name {
        .init(rawValue: "LessonQuizCompleted.Pass")
    }
    
    static var PKGameWon: Notification.Name {
        .init(rawValue: "PKGameCompleted.Won")
    }
    
    static var PKGameLost: Notification.Name {
        .init(rawValue: "PKGameCompleted.Lost")
    }
}
