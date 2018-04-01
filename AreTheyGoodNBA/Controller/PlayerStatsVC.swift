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
    @IBOutlet var testLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let text =  currentPlayer?.name {
            testLabel.text = text
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
