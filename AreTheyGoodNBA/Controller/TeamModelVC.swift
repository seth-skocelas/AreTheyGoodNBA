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
    var statDuration = StatDuration.CurrentSeason

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var gamesPlayed: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService.instance.teamGroup.notify(queue: .main) {
            
            self.setTeamInfo()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTeamStats" {
            
            if let destination = segue.destination as? TeamStatsVC {
                
                if let tuple = sender as? TeamStatsTuple {
                    
                    destination.teamStatsTuple = tuple
                    
                }
                
            }
            
        }
        
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
    
    @IBAction func checkStatsPressed(_ sender: Any) {
        
        WebService.instance.teamGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "toTeamStats", sender: TeamStatsTuple(team: self.currentTeam!,statDuration: self.statDuration))
        }
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            statDuration = StatDuration.CurrentSeason
        } else if segment.selectedSegmentIndex == 1 {
            statDuration = StatDuration.Career
        }
        
    }
    
}
