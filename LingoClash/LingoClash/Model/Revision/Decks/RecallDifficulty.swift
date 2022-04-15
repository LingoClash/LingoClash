//
//  RecallDifficulty.swift
//  LingoClash
//
//  Created by kevin chua on 2/4/22.
//

import Foundation

enum RecallDifficulty: Int, CaseIterable, Codable {
  /// The learner was unable to get the answer
  case again

  /// The learner would like to review the content more frequently, can remember with a lot of help
  case hard

  /// The learner could recall the information needed with the expected amount of difficulty
  case good

  /// The learner would not like to see this prompt again (perhaps 4 days later)
  case easy
}
