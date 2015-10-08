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
    
    var player: Player!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let player = Player.init(name: "Sammy", hp: 200, attack: 20, defense: 10)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chestPressed(sender: AnyObject) {
        
    }
    
    
    
    

}

