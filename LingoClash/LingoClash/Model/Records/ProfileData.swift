//
//  Profile.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 23/3/22.
//

struct ProfileData {
    var id: Identifier
    var book_id: Identifier?
    var user_id: Identifier
    var name: String
    var email: String
    var stars: Int
    var stars_today: Int
    var stars_goal: Int
    var bio: String
    var days_learning: Int
    var vocabs_learnt: Int
    var pk_winning_rate: Double

    init(id: Identifier, book_id: Identifier?, user_id: Identifier,
         stars: Int, stars_goal: Int, bio: String,
         days_learning: Int, vocabs_learnt: Int, pk_winning_rate: Double) {
        self.id = id
        self.book_id = book_id
        self.user_id = user_id
        self.stars = stars
        // TODO: Remove from profile data
        self.stars_today = 0
        self.stars_goal = stars_goal
        self.bio = bio
        self.days_learning = days_learning
        self.vocabs_learnt = vocabs_learnt
        self.pk_winning_rate = pk_winning_rate
    }

        /// Creates a new default profile data for a user.
    init(userId: Identifier) {
        self.init(id: "-1", book_id: nil, user_id: userId,
                  stars: 0, stars_goal: 3,
                  bio: "Life is a journey of learning.",
                  days_learning: 0, vocabs_learnt: 0, pk_winning_rate: 0)
    }
}

extension ProfileData: Record {}
