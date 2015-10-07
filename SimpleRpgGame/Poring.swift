//
//  Poring.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import Foundation

class Poring: Enemy {
    
    override var loot: [String] {
        return ["Angeling Card", "Angeling Axe"]
    }
    
    override var type: String {
        return "Angel Poring"
    }
}