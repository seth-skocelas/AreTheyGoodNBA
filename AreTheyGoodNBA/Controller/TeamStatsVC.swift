//
//  TeamStatsVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/1/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class TeamStatsVC: UIViewController {
    
    var currentTeam: Team?
    
    @IBOutlet weak var testLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let text = currentTeam?.teamName {
            testLabel.text = text
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
