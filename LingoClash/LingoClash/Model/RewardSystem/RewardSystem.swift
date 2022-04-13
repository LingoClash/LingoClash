//
//  RewardSystem.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 1/4/22.
//

import Foundation

class NotificationSystem {
    private static let internalInstance = RewardSystem()
    static var instance: RewardSystem {
        internalInstance
    }
}

class RewardSystem {
    
    func setUpNotifications() {
        print("adhjsad")
        NotificationCenter.default.addObserver(self, selector: #selector(lessonQuizCompleted(_:)), name: .lessonQuizCompleted, object: nil)
    }
    
    func generateReward(fromResult result: LessonQuizResult) -> Reward? {
        // TODO: retrieve user star account
//        starAccount
        
        // TODO: check if user completed lessons 5 days in a row, generate more rewards if so
        return nil
    }
    
    @objc func lessonQuizCompleted(_ notification: Notification) {
        print("hello")
//        print(notification.object as? [String: Any] ?? [:])
    }
}

extension Notification.Name {
    static var lessonQuizCompleted: Notification.Name {
              return .init(rawValue: "LessonQuizCompleted") }
}
