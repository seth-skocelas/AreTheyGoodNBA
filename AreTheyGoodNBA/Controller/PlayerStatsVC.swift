//
//  PlayerStatsVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/1/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class PlayerStatsVC: UIViewController {
    
    var currentPlayer: Player?
    
    @IBOutlet var playerName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var yearsPlayed: UILabel!
    @IBOutlet weak var jerseyNumber: UILabel!
    @IBOutlet weak var position: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currentPlayer?.getAllStats()
        WebService.instance.playerGroup.notify(queue: .main) {
            self.setPlayerInfo()
        }
        
    }
    
    func setPlayerInfo() {
        
        if let text =  currentPlayer?.name {
            playerName.text = text
        }
        
        if let text =  currentPlayer?.startingYear {
            startYear.text = text
        }
        
        if let number =  currentPlayer?.yearsExperience {
            yearsPlayed.text = "\(number)"
        }
        
        if let text =  currentPlayer?.jerseyNumber {
            jerseyNumber.text = text
        }
        
        if let text =  currentPlayer?.position {
            position.text = text
        }
        
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
