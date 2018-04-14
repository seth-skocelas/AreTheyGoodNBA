//
//  League.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/24/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class League {
    
    let name: String = "NBA"
    private var _teams = [Team]()
    
    var teams: [Team] {
        return _teams
    }
    
    init() {
        
        
        WebService.instance.leagueGroup.enter()
        WebService.instance.getFranchiseHistory { (teamsArray) in
            
            var tempTeam: Team
            
            let finalTeamsArray = self.removeDefunctTeamsFromArray(teamsArray: teamsArray as! [Dictionary<String, AnyObject>])
            
            for (index,team) in finalTeamsArray.enumerated() {
                
                tempTeam = Team(teamDict: team, index: index)
                //print(tempTeam.teamName + " has won \(tempTeam.leagueTitles) titles.")
                self._teams.append(tempTeam)
                
            }
            
            WebService.instance.leagueGroup.leave()
            
        }
        
        
        
    }

    func removeDefunctTeamsFromArray(teamsArray: [Dictionary<String, AnyObject>]) -> [Dictionary<String, AnyObject>] {
        
        var finalTeamsArray = teamsArray
        var lastTeamID = 0
        var i = 0
        
        for team in finalTeamsArray {
            
            if team["TEAM_ID"] as? Int != lastTeamID {
                lastTeamID = team["TEAM_ID"] as! Int
            } else {
                finalTeamsArray.remove(at: i)
                i -= 1
            }
            
            i += 1
            
        }
        
        return(finalTeamsArray)
        
    }
    
}
