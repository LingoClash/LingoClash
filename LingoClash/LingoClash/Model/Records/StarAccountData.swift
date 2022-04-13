//
//  StarAccountData.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 12/4/22.
//

struct StarAccountData {
    var id: Identifier
    let owner_id: Identifier
    let balance: Int
}

extension StarAccountData: Record {}

