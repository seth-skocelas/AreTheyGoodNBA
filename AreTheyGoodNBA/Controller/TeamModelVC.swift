//
//  TeamModelVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/4/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class TeamModelVC: UIViewController {
    
    var currentTeam: Team?

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var gamesPlayed: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService.instance.teamGroup.notify(queue: .main) {
            
            self.setTeamInfo()
            
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setTeamInfo() {
        
        if let text = currentTeam?.teamName {
            teamName.text = text
        }
        
        if let text = currentTeam?.startYear {
            startYear.text = text
        }
        
        if let number = currentTeam?.gamesPlayed {
            gamesPlayed.text = "\(number)"
        }
        
    }
    
    
}
