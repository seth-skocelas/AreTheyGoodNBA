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
    private var _selectedSeason: String!
    private var _teams = [Team]()
    private var _standings = [Dictionary<String, AnyObject>]()
    
    var teams: [Team] {
        return _teams
    }
    
    var standings: [Dictionary<String, AnyObject>] {
        return _standings
    }
    
    var selectedSeason: String {
        if _selectedSeason == nil {
            return ""
        }
        return _selectedSeason
    }
    
    init(selectedSeason: String) {
        
        
        WebService.instance.leagueGroup.enter()
        WebService.instance.getFranchiseHistory { (teamsArray) in
            
            var tempTeam: Team
            
            let finalTeamsArray = self.removeDefunctTeamsFromArray(teamsArray: teamsArray as! [Dictionary<String, AnyObject>])
            
            for (index,team) in finalTeamsArray.enumerated() {
                
                tempTeam = Team(teamDict: team, index: index, leagueName: WebService.instance.currentLeague)
                tempTeam.selectedSeason = selectedSeason
                //print("\(tempTeam.teamID) " + " has won \(tempTeam.leagueTitles) titles.")
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
    
    func adjustTeamListBySeason(seasonString: String) {
        
        _teams = teams.sorted(by: { $0.teamName < $1.teamName })
        
        
        switch seasonString {
            
            case "1996-97":
                _teams[2].teamName = "New Jersey Nets"
                _teams[14].teamName = "Vancouver Grizzlies"
                _teams[20].teamName = "Seattle SuperSonics"
                _teams[29].teamName = "Washington Bullets"
                _teams.remove(at: 18)
                break
            case "1997-98","1998-99","2000-01":
                _teams[2].teamName = "New Jersey Nets"
                _teams[14].teamName = "Vancouver Grizzlies"
                _teams[20].teamName = "Seattle SuperSonics"
                _teams.remove(at: 18)
                break
            case "2001-02":
                _teams[2].teamName = "New Jersey Nets"
                _teams[20].teamName = "Seattle SuperSonics"
                _teams.remove(at: 18)
                break
            case "2002-03","2003-04":
                _teams[2].teamName = "New Jersey Nets"
                _teams[18].teamName = "New Orleans Hornets"
                _teams[20].teamName = "Seattle SuperSonics"
                _teams.remove(at: 3)
                break
            case "2004-05","2005-06","2006-07","2007-08":
                _teams[2].teamName = "New Jersey Nets"
                _teams[3].teamName = "Charlotte Bobcats"
                _teams[18].teamName = "New Orleans Hornets"
                _teams[20].teamName = "Seattle SuperSonics"
                break
            case "2008-09","2009-10","2010-11","2011-12":
                _teams[2].teamName = "New Jersey Nets"
                _teams[3].teamName = "Charlotte Bobcats"
                _teams[18].teamName = "New Orleans Hornets"
                break
            case "2012-13":
                _teams[3].teamName = "Charlotte Bobcats"
                _teams[18].teamName = "New Orleans Hornets"
                break
            case "2013-14":
                _teams[3].teamName = "Charlotte Bobcats"
                break
            default:
                break
        }
        
        _teams = teams.sorted(by: { $0.teamName < $1.teamName })
    }
 
}
