//
//  BookDataManager.swift
//  LingoClash
//
//  Created by Kyle キラ on 22/3/22.
//

import PromiseKit
import Foundation

class LessonManager: DataManager<LessonData> {

    init() {
        super.init(resource: DataManagerResources.lessons)
    }

    // This method should be here instead of ProfileLessonManager as users are unaware of ProfileLesson
    func completeLesson(_ lesson: Lesson) {
        let profileManager = ProfileManager()
        let profileLessonManager = ProfileLessonManager()

        _ = firstly {
            profileLessonManager.getOneCurrentUser(lessonId: lesson.id)
        }.then { profileLessonData -> Promise<ProfileLessonData> in
            let didGainStars = profileLessonData.stars < lesson.stars
            
            if didGainStars {
                let modifiedData = ProfileLessonData(id: profileLessonData.id, profile_id: profileLessonData.profile_id,
                                                     profile_book_id: profileLessonData.profile_book_id,
                                                     lesson_id: profileLessonData.lesson_id,
                                                     stars: lesson.stars)
                _ = profileLessonManager.update(id: profileLessonData.id, to: modifiedData)
                
                NotificationCenter.default.post(name: .lessonQuizPassed, object: nil, userInfo: ["stars": lesson.stars -  profileLessonData.stars])
            }
            return Promise<ProfileLessonData>.resolve(value: profileLessonData)
        }.done { oldProfileLessonData in
            // increment vocabslearnt
            let didPassNewLesson = !oldProfileLessonData.didPass() && lesson.didPass
            if didPassNewLesson {
                // This assumes that vocabs learnt between lessons do not overlap
                profileManager.incrementVocabsLearnt(by: lesson.vocabs.count)
            }
        }.catch { error in
            Logger.error(error.localizedDescription)
        }
    }
}
