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

    @IBOutlet weak var chestBtn: UIButton!
    @IBOutlet weak var attackBtn: UIButton!
    
    var player: Player!
    var enemy: Enemy!
    var chestMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the player object, generate the enemy and set player lbl hp
        player = Player.init(name: "Sammy", hp: 200, attack: 20, defense: 10)
        playerHpLbl.text = "\(player.hp) HP"

        generateEnemy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateEnemy() {
        // Show the attack button
        attackBtn.hidden = false
        
        // make a random number between 0 and 1 to know 
        // which enemy we're going to make and add it custom image (Poring is default image)
        let rand = Int(arc4random_uniform(2))
        var pngForEnemy: String = "poring"
        
        if rand == 0 {
            enemy = Poring(hp: 130, attack: 10, defense: 6)
        } else {
            enemy = Orc(hp: 167, attack: 21, defense: 16)
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
    
    @IBAction func chestPressed(sender: AnyObject) {
        let nbSeconds: Double = 3.0
        
        chestBtn.hidden = true
        printLbl.text = chestMessage

        /// Wait 3 seconds before re generate a new enemy
        NSTimer.scheduledTimerWithTimeInterval(nbSeconds, target: self, selector: "generateEnemy", userInfo: nil, repeats: false)
    }
    
    @IBAction func attackPressed(sender: AnyObject) {
        
        // If the attack succeed we show the amount of attack and decrease enemy HP
        if enemy.attemptAttack(player.attack) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attack) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "You missed the Enemy"
        }

        /* So, the enemy is dead */
        
        // We delete the HP Label of the enemy
        // We set the main Label to congratulate the Player
        // We hide the Enemy (is dead) and we hide the attack button (no one to attack now)
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed enemy \(enemy.type)"
            enemyImg.hidden = true
            attackBtn.hidden = true
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
    

}

