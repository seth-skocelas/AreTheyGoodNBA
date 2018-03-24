//
//  Team.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/15/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


/*
 
 "LEAGUE_ID",
 "TEAM_ID",
 "TEAM_CITY",
 "TEAM_NAME",
 "START_YEAR",
 "END_YEAR",
 "YEARS",
 "GAMES",
 "WINS",
 "LOSSES",
 "WIN_PCT",
 "PO_APPEARANCES",
 "DIV_TITLES",
 "CONF_TITLES",
 "LEAGUE_TITLES"
 
 */

class Team {
    
    private var _teamID: Int!
    private var _teamName: String!
    private var _startYear: String!
    private var _years: Int!
    private var _gamesPlayed: Int!
    private var _wins: Int!
    private var _losses: Int!
    private var _winPercentage: Float!
    private var _playoffApperances: Int!
    private var _divisionTitles: Int!
    private var _conferenceTitles: Int!
    private var _leagueTitles: Int!
    
    private var _teamRoster = [Player]()
    
    var teamName: String {
        if _teamName == nil {
            return ""
        }
        return _teamName
    }
    
    var teamID: Int {
        if _teamID == nil {
            return -1
        }
        return _teamID
    }
    
    var startYear: String {
        if _startYear == nil {
            return ""
        }
        return _startYear
    }
    
    var years: Int {
        if _years == nil {
            return -1
        }
        return _years
    }
    
    var gamesPlayed: Int {
        if _gamesPlayed == nil {
            return -1
        }
        return _gamesPlayed
    }
    
    var wins: Int {
        if _wins == nil {
            return -1
        }
        return _wins
    }
    
    var losses: Int {
        if _losses == nil {
            return -1
        }
        return _losses
    }
    
    var winPercentage: Float {
        if _winPercentage == nil {
            return -1
        }
        return _winPercentage
    }
    
    var playoffApperances: Int {
        if _playoffApperances == nil {
            return -1
        }
        return _playoffApperances
    }
    
    var divisionTitles : Int {
        if _divisionTitles  == nil {
            return -1
        }
        return _divisionTitles
    }
    
    var conferenceTitles: Int {
        if _conferenceTitles == nil {
            return -1
        }
        return _conferenceTitles
    }
    
    var leagueTitles: Int {
        if _leagueTitles == nil {
            return -1
        }
        return _leagueTitles
    }
    
    var teamRoster: [Player] {
        return _teamRoster
    }
    
    
    
    init(teamDict: Dictionary<String, AnyObject>) {
        
        _teamID = teamDict["TEAM_ID"] as! Int
        _teamName = "\(teamDict["TEAM_CITY"] ?? "Not" as AnyObject) \(teamDict["TEAM_NAME"] ?? "Available" as AnyObject)"
        _startYear = teamDict["START_YEAR"] as! String
        _years = teamDict["YEARS"] as! Int
        _gamesPlayed = teamDict["GAMES"] as! Int
        _wins = teamDict["WINS"] as! Int
        _losses = teamDict["LOSSES"] as! Int
        _winPercentage = teamDict["WIN_PCT"] as! Float
        _playoffApperances = teamDict["PO_APPEARANCES"] as! Int
        _divisionTitles = teamDict["DIV_TITLES"] as! Int
        _conferenceTitles = teamDict["CONF_TITLES"] as! Int
        _leagueTitles = teamDict["LEAGUE_TITLES"] as! Int
        
        if (_teamName == "Dallas Mavericks") {
            getTeamRoster()
        }
        
    }
    
    func getTeamRoster() {
        
        WebService.instance.getCommonTeamRoster(teamID: self.teamID) { (teamArray) in
            
            for player in teamArray {
                
                self._teamRoster.append(Player(commonPlayerInfo: player, fromTeamRoster: true))
                
            }
            
            for player in self.teamRoster {
                print(player.name)
            }
            
        }
        
    }
    

    
    
    
    
}
