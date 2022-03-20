//
//  Lesson.swift
//  LingoClash
//
//  Created by Sherwin Poh on 19/3/22.
//

import Foundation

class Lesson {
    let lessonName: String
    let lessonId: Int
    var vocabs = [Vocab]()
    var questions = [Question]()
    
    init(lessonName: String, lessonId: Int) {
        self.lessonName = lessonName
        self.lessonId = lessonId
    }
}
