//
//  ItemTypes.swift
//  LingoClash
//
//  Created by Ai Ling Hong on 3/4/22.
//

protocol Item: Hashable {}

class PowerUp: Item {
    static func == (lhs: PowerUp, rhs: PowerUp) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}

class Equipment: Item {
    static func == (lhs: Equipment, rhs: Equipment) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}
