//
//  Team.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/15/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class Team {
    
    private var _teamID: Int!
    private var _teamAbbreviation: String!
    private var _teamName: String!
    private var _startYear: String!
    private var _years: Int!
    private var _gamesPlayed: Int!
    private var _wins: Int!
    private var _losses: Int!
    private var _winPercentage: Double!
    private var _playoffApperances: Int!
    private var _divisionTitles: Int!
    private var _conferenceTitles: Int!
    private var _leagueTitles: Int!
    private var _selectedSeason: String!
    
    private var _currentWins: Int!
    private var _currentLosses: Int!
    private var _currentWinPer: Double!
    
    private var _currentRegularSeasonTradStats: TradStats!
    private var _currentPostSeasonTradStats: TradStats!
    
    private var _currentRegularSeasonAdvStats: AdvStats!
    private var _currentPostSeasonAdvStats: AdvStats!
    
    private var _teamRoster = [Player]()
    private var _image: ClassTypeImage!
    
    var teamName: String {
        get {
            if _teamName == nil {
                return ""
            }
            return _teamName
            }
        set (newName) {
            _teamName = newName
        }
    }
    
    var teamAbbreviation: String {
        if _teamAbbreviation == nil {
            return "N/A"
        }
        return _teamAbbreviation
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
    
    var winPercentage: Double {
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
    
    var selectedSeason: String {
        get {
            if _selectedSeason == nil {
                return ""
            }
            return _selectedSeason
        }
        set (newSeason) {
            _selectedSeason = newSeason
        }
    }
    
    var currentWins: Int {
        if _currentWins == nil {
            return -1
        }
        return _currentWins
    }
    
    var currentLosses: Int {
        if _currentLosses == nil {
            return -1
        }
        return _currentLosses
    }
    
    var currentWinPer: Double {
        if _currentWinPer == nil {
            return -1.0
        }
        return _currentWinPer
    }
    
    var teamRoster: [Player] {
        return _teamRoster
    }
    
    var image: ClassTypeImage {
        
        get {
            if _image == nil {
                return ClassTypeImage()
            }
            
            return _image
        }
        
    }
    
    var currentRegularSeasonTradStats: TradStats {
        if _currentRegularSeasonTradStats == nil {
            return TradStats()
        }
        return _currentRegularSeasonTradStats
    }
    
    var currentPostSeasonTradStats: TradStats {
        if _currentPostSeasonTradStats == nil {
            return TradStats()
        }
        return _currentPostSeasonTradStats
    }
    
    var currentRegularSeasonAdvStats: AdvStats {
        if _currentRegularSeasonAdvStats == nil {
            return AdvStats()
        }
        return _currentRegularSeasonAdvStats
    }
    
    var currentPostSeasonAdvStats: AdvStats {
        if _currentPostSeasonAdvStats == nil {
            return AdvStats()
        }
        return _currentPostSeasonAdvStats
    }
    
    
    init() {}
    
    init(teamDict: Dictionary<String, AnyObject>, index: Int) {
        
        if teamDict.count != 0 {
        
            _teamID = teamDict["TEAM_ID"] as? Int
            _teamName = "\(teamDict["TEAM_CITY"] ?? "Not" as AnyObject) \(teamDict["TEAM_NAME"] ?? "Available" as AnyObject)"
            _teamAbbreviation = teamAbbrevaiationArray[index]
            _startYear = teamDict["START_YEAR"] as? String
            _years = teamDict["YEARS"] as? Int
            _gamesPlayed = teamDict["GAMES"] as? Int
            _wins = teamDict["WINS"] as? Int
            _losses = teamDict["LOSSES"] as? Int
            _winPercentage = teamDict["WIN_PCT"]?.doubleValue
            _playoffApperances = teamDict["PO_APPEARANCES"] as? Int
            _divisionTitles = teamDict["DIV_TITLES"] as? Int
            _conferenceTitles = teamDict["CONF_TITLES"] as? Int
            _leagueTitles = teamDict["LEAGUE_TITLES"] as? Int
            
        }
        
    }
    
    func loadTeamRecord(wins: Int, losses: Int, winPer: Double) {
        
        _currentWins = wins
        _currentLosses = losses
        _currentWinPer = winPer
        
    }
    
    func getTeamRoster() {
        
        if teamRoster.count == 0 {
            
            WebService.instance.teamGroup.enter()
            WebService.instance.getCommonTeamRoster(teamID: self.teamID) { (teamArray) in
            
                for player in teamArray {
                    
                    let createdPlayer = Player(commonPlayerInfo: player, fromTeamRoster: true)
                    createdPlayer.selectedSeason = self.selectedSeason
                    self._teamRoster.append(createdPlayer)
                
                }
            
                WebService.instance.teamGroup.leave()
                
            }
            
        }
        
    }
    
    func getAllStats() {
        
        getTeamStats(measureType: MeasureType.RegularBase)
        getTeamStats(measureType: MeasureType.PostBase)
        
        getTeamStats(measureType: MeasureType.RegularAdvanced)
        getTeamStats(measureType: MeasureType.PostAdvanced)

    }
    
    func setClassTypeImage() {
        _image = ClassTypeImage(team: self)
    }
    
    func getTeamStats(measureType: MeasureType) {
        
        if (measureType == MeasureType.RegularBase) {
            
            WebService.instance.teamGroup.enter()
            WebService.instance.getTeamSeasonStats(teamID: self.teamID, measureType: measureType) { (teamStats) in
                
                self._currentRegularSeasonTradStats = TradStats(classType: ClassType.Team, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: teamStats)
                //print("Test: \(self.currentRegularSeasonTradStats.gamesPlayed), \(self.currentRegularSeasonTradStats.fieldGoalPercent)")
                
                WebService.instance.teamGroup.leave()
                
            }
        }
            
        else if (measureType == MeasureType.PostBase) {
             
            WebService.instance.teamGroup.enter()
            WebService.instance.getTeamSeasonStats(teamID: self.teamID, measureType: measureType) { (teamStats) in
                
                if teamStats.count != 0 {
                    self._currentPostSeasonTradStats = TradStats(classType: ClassType.Team, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: teamStats)
                    //print("Test: \(self.currentPostSeasonTradStats.gamesPlayed), \(self.currentPostSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("The playoffs haven't started yet")
                }
                WebService.instance.teamGroup.leave()
            }
        }
        
        else if (measureType == MeasureType.RegularAdvanced) {
            
            WebService.instance.teamGroup.enter()
            WebService.instance.getTeamSeasonStats(teamID: self.teamID, measureType: measureType) { (teamStats) in
                
                self._currentRegularSeasonAdvStats = AdvStats(classType: ClassType.Team, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: teamStats)
                //print("Test: \(self.currentRegularSeasonAdvStats.pace), \(self.currentRegularSeasonAdvStats.trueShooting)")
                
                WebService.instance.teamGroup.leave()
                
            }
            
        }
            
        else if (measureType == MeasureType.PostAdvanced) {
            
            WebService.instance.teamGroup.enter()
            WebService.instance.getTeamSeasonStats(teamID: self.teamID, measureType: measureType) { (teamStats) in
                
                if teamStats.count != 0 {
                    self._currentPostSeasonAdvStats = AdvStats(classType: ClassType.Team, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: teamStats)
                    //print("Test: \(self.currentPostSeasonAdvStats.pace), \(self.currentPostSeasonAdvStats.trueShooting)")
                } else {
                    print("The playoffs haven't started yet")
                }
                WebService.instance.teamGroup.leave()
            }
        }
        
    }
    

    
    
    
    
}
