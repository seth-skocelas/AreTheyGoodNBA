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
    var statDuration: StatDuration?
    var teamStatsTuple: TeamStatsTuple?
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var gamesPlayed: UILabel!
    
    @IBOutlet weak var measureTypeSegment: UISegmentedControl!
    
    @IBOutlet weak var regularSeasonStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var franchiseStackView: UIStackView!
    
    @IBOutlet weak var gamesPlayedStatPage: UILabel!
    @IBOutlet weak var minutesPlayed: UILabel!
    @IBOutlet weak var fieldGoalPercent: UILabel!
    @IBOutlet weak var threePointPercent: UILabel!
    @IBOutlet weak var fieldGoalsMade: UILabel!
    @IBOutlet weak var threePointsMade: UILabel!
    @IBOutlet weak var fieldGoalAttempts: UILabel!
    @IBOutlet weak var threePointAttempts: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rebounds: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var turnovers: UILabel!
    @IBOutlet weak var plusMinus: UILabel!
    @IBOutlet weak var plusMinusLabel: UILabel!
    
    @IBOutlet weak var offRating: UILabel!
    @IBOutlet weak var defRating: UILabel!
    @IBOutlet weak var netRating: UILabel!
    @IBOutlet weak var usage: UILabel!
    @IBOutlet weak var effectiveFG: UILabel!
    @IBOutlet weak var trueShooting: UILabel!
    @IBOutlet weak var pace: UILabel!
    @IBOutlet weak var pie: UILabel!
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    @IBOutlet weak var winPercentage: UILabel!
    @IBOutlet weak var playoffApperances: UILabel!
    @IBOutlet weak var divisionTitles: UILabel!
    @IBOutlet weak var conferenceTitles: UILabel!
    @IBOutlet weak var leagueTitles: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTeamInfo()
        
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
        
        if let year = currentTeam?.gamesPlayed {
            gamesPlayed.text = "\(year)"
        }
        
    }
    

}
