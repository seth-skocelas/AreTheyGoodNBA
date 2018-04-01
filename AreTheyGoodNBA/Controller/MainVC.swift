//
//  MainVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/7/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var league: League!
    var selectedTeam: Team!
    
    @IBOutlet weak var teamPicker: UIPickerView!
    @IBOutlet weak var playerPicker: UIPickerView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        teamPicker.delegate = self
        teamPicker.dataSource = self
        
        playerPicker.delegate = self
        playerPicker.dataSource = self
        
        asyncTestFunc()
        
        //2544 = Lebron
        //1628372 = DSJ
    
    }
    
    func asyncTestFunc() {
        
        league = League()
        
        WebService.instance.leagueGroup.notify(queue: .main) {
            
            self.teamPicker.reloadAllComponents()
            
            print("\(self.league.teams[0].teamName)")
            
            self.selectedTeam = self.league.teams[0]
            self.league.teams[0].getTeamRoster()
            
            WebService.instance.teamGroup.notify(queue: .main) {
                
                self.playerPicker.reloadAllComponents()
                
                print("\(self.league.teams[0].teamRoster[0].name): \(self.league.teams[0].teamRoster[0].playerID)")
                self.league.teams[0].teamRoster[0].getAllStats()
                
                WebService.instance.playerGroup.notify(queue: .main) {
                    
                    print("Regular Season TS%: \(self.league.teams[0].teamRoster[0].currentRegularSeasonAdvStats.trueShooting)")
                    print("Career PTS: \(self.league.teams[0].teamRoster[0].careerRegularSeasonTradStats.points)")
                    
                }
            }
        }
    }

}

extension MainVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString = NSAttributedString()
        
        if pickerView.tag == 1 {
            
            let team = league.teams[row]
            attributedString = NSAttributedString(string: team.teamName, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
        } else if pickerView.tag == 2 {
            
            let player = selectedTeam.teamRoster[row]
            attributedString = NSAttributedString(string: player.name, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        }
        
        return attributedString
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return league.teams.count
        } else if pickerView.tag == 2 {
            
            if selectedTeam == nil {
                return 0
            } else {
                return selectedTeam.teamRoster.count
            }
            
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            
            selectedTeam = league.teams[row]
            selectedTeam.getTeamRoster()
            
            WebService.instance.teamGroup.notify(queue: .main) {
                self.playerPicker.reloadAllComponents()
            }
            
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

    


