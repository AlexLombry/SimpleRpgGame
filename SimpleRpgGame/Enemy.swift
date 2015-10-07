//
//  Enemy.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import Foundation

class Enemy: Character {

    var loot: [String] {
        return ["Dagger", "Cracked shield"]
    }
    
    var type: String {
        return "Grunt"
    }
    
    func dropLoot() -> String? {
        if !isAlive {
            let rand = Int(arc4random_uniform(UInt32(loot.count)))
            
            return loot[rand]
        }
        
        return nil
    }
    
}