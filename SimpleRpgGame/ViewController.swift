//
//  ViewController.swift
//  SimpleRpgGame
//
//  Created by Alex Lombry on 07/10/15.
//  Copyright © 2015 Alex Lombry. All rights reserved.
//

import UIKit

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

    func generateEnemy() {
        attackBtn.hidden = false
        let rand = Int(arc4random_uniform(2))
        var pngForEnemy: String = "poring"
        
        if rand == 0 {
            enemy = Poring(hp: 130, attack: 10, defense: 6)
        } else {
            enemy = Orc(hp: 167, attack: 21, defense: 16)
            pngForEnemy = "orc"
        }
        
        beforeEnemyLaunch(pngForEnemy)

    }
    
    ///Set HP Label, image and text for enemy
    func beforeEnemyLaunch(pngForEnemy: String) {
        enemyImg.image = UIImage(named: pngForEnemy)
        enemyImg.hidden = false
        enemyHpLbl.text = "\(enemy.hp) HP"
        printLbl.text = "Fighting \(enemy.type)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chestPressed(sender: AnyObject) {
        let nbSeconds: Double = 3.0
        chestBtn.hidden = true
        printLbl.text = chestMessage
        printLbl.text = "New enemy may appears in \(Int(nbSeconds)) seconds"
        
        /// Wait 3 seconds before re generate a new enemy
        NSTimer.scheduledTimerWithTimeInterval(nbSeconds, target: self, selector: "generateEnemy", userInfo: nil, repeats: false)
    }
    
    @IBAction func attackPressed(sender: AnyObject) {
        
        if enemy.attemptAttack(player.attack) {
            printLbl.text = "Attacked \(enemy.type) for \(player.attack) HP"
            enemyHpLbl.text = "\(enemy.hp) HP"
        } else {
            printLbl.text = "You missed the Enemy"
        }
        
        // If enemy drop a loot
        if let loot = enemy.dropLoot() {
            player.addItemToStorage(loot)
            chestMessage = "\(player.name) has found \(loot)"
            chestBtn.hidden = false
        }
        
        // If enemy is dead
        if !enemy.isAlive {
            enemyHpLbl.text = ""
            printLbl.text = "Killed enemy \(enemy.type)"
            enemyImg.hidden = true
            
            // The enemy is dead so we don't need anymore the attack button
            attackBtn.hidden = true
        }
    }
    

}

