//
//  Character.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import Foundation

class Character {
    
    /// Health of character
    private var _hp: Int = 100
    
    /// Attack power of character
    private var _attack: Int = 10
    
    /// Defense lvl (used on Enemy for now
    private var _defense: Int = 10
    
    var hp: Int {
        get {
            return _hp
        }
        set {
            _hp = newValue
        }
    }
    
    var attack: Int {
        get {
            return _attack
        }
    }
    
    var defense: Int {
        get {
            return _defense
        }
    }
    
    var isAlive: Bool {
        get {
            return hp > 0
        }
    }
    
    init(startingHp: Int, attackPower: Int, defensePoint: Int) {
        self._hp = startingHp
        self._attack = attackPower
        self._defense = defensePoint
    }

    // Attacking the character
    // set _hp variable - attack power
    func attemptAttack(attack: Int) -> Bool {
        self._hp -= attack
        
        return true
    }
}