//
//  ViewController.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var printLbl: UILabel!
    @IBOutlet weak var playerHpLbl: UILabel!
    @IBOutlet weak var enemyHpLbl: UILabel!
    
    @IBOutlet weak var enemyImg: UIImageView!
    @IBOutlet weak var playerImg: UIImageView!
    
    @IBOutlet weak var chestBtn: UIButton!
    @IBOutlet weak var attackBtn: UIButton!
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?
    var randomAttackPower: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomAttackPower = generateRandomAttackPower(min: 10, max: 30)
        
        // set the player object, generate the enemy and set player lbl hp
        player = Player.init(name: "Sammy", hp: 200, attack: randomAttackPower, defense: 10)
        playerHpLbl.text = "\(player.hp) HP"

        generateEnemy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateRandomAttackPower(min min: Int, max: Int) -> Int {
        if max < min {
            return min
        } else {
            return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
        }
    }
    
    func generateEnemy() {
        // Show the attack button
        attackBtn.hidden = false
        
        // make a random number between 0 and 1 to know 
        // which enemy we're going to make and add it custom image (Poring is default image)
        let rand = Int(arc4random_uniform(2))
        var pngForEnemy: String = "poring"
        
        if rand == 0 {
            randomAttackPower = generateRandomAttackPower(min: 4, max: 18)
            enemy = Poring(hp: 130, attack: randomAttackPower, defense: 6)
        } else {
            randomAttackPower = generateRandomAttackPower(min: 14, max: 26)
            enemy = Orc(hp: 167, attack: randomAttackPower, defense: 16)
            pngForEnemy = "orc"
        }
        
        // Just before launching enemy, 
        // make some property for image and label
        beforeEnemyLaunch(pngForEnemy)

    }
    
    ///Set HP Label, image and text for enemy
    func beforeEnemyLaunch(pngForEnemy: String) {
        enemyImg.image = UIImage(named: pngForEnemy)
        enemyImg.hidden = false
        enemyHpLbl.text = "\(enemy.hp) HP"
        printLbl.text = "Fighting \(enemy.type)"
    }
    
    func playerAttack() {
        // If the attack succeed we show the amount of attack and decrease enemy HP
        if enemy.attemptAttack(player.attack) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attack) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "You missed the Enemy"
        }
    }
    
    func enemyAttack() {
        printLbl.text = "Enemy attack you, protect yourself"
        if player.attemptAttack(enemy.attack) {
            printLbl.text = "Attacked \(player.name) for \(enemy.attack) HP"
            playerHpLbl.text = "\(player.hp) HP"
        } else {
            printLbl.text = "Enemy missed you"
        }
    }
    
    @IBAction func chestPressed(sender: AnyObject) {
        let nbSeconds: Double = 3.0
        
        chestBtn.hidden = true
        printLbl.text = chestMessage

        /// Wait 3 seconds before re generate a new enemy
        NSTimer.scheduledTimerWithTimeInterval(nbSeconds, target: self, selector: "generateEnemy", userInfo: nil, repeats: false)
    }
    
    @IBAction func attackPressed(sender: AnyObject) {
        playerAttack()
        // We delete the HP Label of the enemy
        // We set the main Label to congratulate the Player
        // We hide the Enemy (is dead) and we hide the attack button (no one to attack now)
        // Otherwize enemy attack
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed enemy \(enemy.type)"
            enemyImg.hidden = true
            attackBtn.hidden = true
        } else {
            // Enemy attack
            NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "enemyAttack", userInfo: nil, repeats: false)
        }
        
        if !player.isAlive {
            gameOver()
        }
        
        // If enemy drop a loot
        if let loot = enemy.dropLoot() {
            if !player.storage.contains(loot) {
                chestMessage = "\(player.name) has found \(loot)"
            } else {
                chestMessage = "\(player.name) has found another \(loot)"
            }
            
            player.addItemToStorage(loot)
            chestBtn.hidden = false
        }

    }
    
    func gameOver() {
        printLbl.text = "GAME OVER"
        
        playerImg.hidden = true
        attackBtn.hidden = true
        chestBtn.hidden = true
        
        playerHpLbl.hidden = true
        enemyHpLbl.hidden = true
    }

}

