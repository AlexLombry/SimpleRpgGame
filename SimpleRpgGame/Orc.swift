//
//  Orc.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import Foundation

class Orc: Enemy {
    
    override var loot: [String] {
        return ["Bronze Dagger", "Orcish Coin", "Orc Card"];
    }
    
    override var type: String {
        return "Orc Warrior"
    }
    
    override func attemptAttack(_ attack: Int) -> Bool {
        return attack >= defense ? super.attemptAttack(attack) : false
    }
}
