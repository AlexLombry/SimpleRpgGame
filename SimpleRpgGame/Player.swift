//
//  Player.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import Foundation

class Player: Character {
    
    /// Set the player name
    private var _name = "Player 1"
    
    /// Character storage (only for Player)
    private var _storage = [String]()
    
    var name: String {
        get {
            return _name
        }
    }
    
    var storage: [String] {
        return _storage
    }

    func addItemToStorage(item: String) {
        _storage.append(item)
    }
    
    convenience init(name: String, hp: Int, attack: Int, defense: Int) {
        self.init(startingHp: hp, attackPower: attack, defensePoint: defense)
        
        _name = name
    }
}