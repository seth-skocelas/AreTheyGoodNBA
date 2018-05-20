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
    private var _standings = [Dictionary<String, AnyObject>]()
    
    var teams: [Team] {
        return _teams
    }
    
    var standings: [Dictionary<String, AnyObject>] {
        return _standings
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
        
        WebService.instance.leagueGroup.enter()
        WebService.instance.getTeamStandings { (teamStandings) in
            
            self._standings = (teamStandings as? [Dictionary<String,AnyObject>])!
            
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
    
    func loadTeamStandings() {
        
        for team in teams {
            
            for dict in standings {
                
                if let teamID = dict["TeamID"] as? Int {
                    
                    if team.teamID == teamID {
                        
                        if let wins = dict["WINS"] as? Int, let losses = dict["LOSSES"] as? Int, let winPer = dict["WinPCT"] as? Double {
                            team.loadTeamRecord(wins: wins, losses: losses, winPer: winPer)
                        } else {
                            print("Unable to load team standings")
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
