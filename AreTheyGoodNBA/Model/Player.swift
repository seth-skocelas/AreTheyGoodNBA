//
//  Player.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/15/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class Player {
    
    private var _name: String!
    private var _playerID: Int!  //nba.com ID
    private var _teamID: Int!
    private var _height: String!
    private var _weight: String!
    private var _yearsExperience: Int!
    private var _jerseyNumber: String!
    private var _position: String!
    private var _currentTeam: String!
    private var _startingYear: String!
    
    private var _currentRegularSeasonTradStats: TradStats!
    private var _currentPostSeasonTradStats: TradStats!
    private var _careerRegularSeasonTradStats: TradStats!
    private var _careerPostSeasonTradStats: TradStats!
    
    private var _currentRegularSeasonAdvStats: AdvStats!
    private var _currentPostSeasonAdvStats: AdvStats!
    private var _careerRegularSeasonAdvStats: AdvStats!
    private var _careerPostSeasonAdvStats: AdvStats!
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var playerID: Int {
        if _playerID == nil {
            return -1
        }
        return _playerID
    }
    
    var teamID: Int {
        if _teamID == nil {
            return -1
        }
        return _teamID
    }
    
    var yearsExperience: Int {
        if _yearsExperience == nil {
            return -1
        }
        return _yearsExperience
    }
    
    var jerseyNumber: String {
        if _jerseyNumber == nil {
            return ""
        }
        return _jerseyNumber
    }
    
    var position: String {
        if _position == nil {
            return ""
        }
        return _position
    }
    
    var currentTeam: String {
        if _currentTeam == nil {
            return ""
        }
        return _currentTeam
    }
    
    var startingYear: String {
        if _startingYear == nil {
            return ""
        }
        return _startingYear
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
    
    var careerRegularSeasonTradStats: TradStats {
        if _careerRegularSeasonTradStats == nil {
            return TradStats()
        }
        return _careerRegularSeasonTradStats
    }
    
    var careerPostSeasonTradStats: TradStats {
        if _careerPostSeasonTradStats == nil {
            return TradStats()
        }
        return _careerPostSeasonTradStats
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
    
    var careerRegularSeasonAdvStats: AdvStats {
        if _careerRegularSeasonAdvStats == nil {
            return AdvStats()
        }
        return _careerRegularSeasonAdvStats
    }
    
    var careerPostSeasonAdvStats: AdvStats {
        if _careerPostSeasonAdvStats == nil {
            return AdvStats()
        }
        return _careerPostSeasonAdvStats
    }
    
    init() {}
    
    
    //Get data from nba.com API dictionary
    init(commonPlayerInfo: Dictionary<String, AnyObject>) {
        
        _name = commonPlayerInfo["DISPLAY_FIRST_LAST"] as! String
        _playerID = commonPlayerInfo["PERSON_ID"] as! Int
        _teamID = commonPlayerInfo["TEAM_ID"] as! Int
        _height = commonPlayerInfo["HEIGHT"] as! String
        _weight = commonPlayerInfo["WEIGHT"] as! String
        _yearsExperience = commonPlayerInfo["SEASON_EXP"] as! Int
        _jerseyNumber = commonPlayerInfo["JERSEY"] as! String
        _position = commonPlayerInfo["POSITION"] as! String
        _currentTeam = "\(commonPlayerInfo["TEAM_CITY"] as! String) \(commonPlayerInfo["TEAM_NAME"] as! String)"
        _startingYear = commonPlayerInfo["DRAFT_YEAR"] as! String
        
    }
    
    //Creating a player from CommonTeamRoster is different from CommonPlayerInfo. I should probably combine into one init using the bool to check
    
    init(commonPlayerInfo: Dictionary<String, AnyObject>, fromTeamRoster: Bool) {
        
        _name = commonPlayerInfo["PLAYER"] as! String
        _teamID = commonPlayerInfo["TeamID"] as! Int
        _playerID = commonPlayerInfo["PLAYER_ID"] as! Int
        _height = commonPlayerInfo["HEIGHT"] as! String
        _weight = commonPlayerInfo["WEIGHT"] as! String
        _jerseyNumber = commonPlayerInfo["NUM"] as! String
        _position = commonPlayerInfo["POSITION"] as! String
        
    }
    
    func getAllStats() {
        
        getCommonPlayerInfo()
        getPlayerStats(measureType: MeasureType.RegularBase, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(measureType: MeasureType.PostBase, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(statDuration: StatDuration.Career)
        
        getPlayerStats(measureType: MeasureType.RegularAdvanced, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(measureType: MeasureType.PostAdvanced, statDuration: StatDuration.CurrentSeason)
        
    }
    
    func getPlayerStats(measureType: MeasureType, statDuration: StatDuration) {
        
        if (measureType == MeasureType.RegularBase && statDuration == StatDuration.CurrentSeason) {
            
            WebService.instance.playerGroup.enter()
            WebService.instance.getPlayerSeasonStats(playerID: self.playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                self._currentRegularSeasonTradStats = TradStats(classType: ClassType.Player, statType: measureType, statDuration: statDuration, dict: currentSeason)
                //print("Test: \(self.currentRegularSeasonTradStats.gamesPlayed), \(self.currentRegularSeasonTradStats.fieldGoalPercent)")
                
                WebService.instance.playerGroup.leave()
            }
            
        }
        
        else if (measureType == MeasureType.PostBase && statDuration == StatDuration.CurrentSeason) {
            
            WebService.instance.playerGroup.enter()
            WebService.instance.getPlayerSeasonStats(playerID: self.playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                if currentSeason.count != 0 {
                    self._currentPostSeasonTradStats = TradStats(classType: ClassType.Player, statType: measureType, statDuration: statDuration, dict: currentSeason)
                    //print("Test: \(self.currentPostSeasonTradStats.gamesPlayed), \(self.currentPostSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("The playoffs haven't started yet")
                }
                WebService.instance.playerGroup.leave()
            }
        }
        
        else if (measureType == MeasureType.RegularAdvanced) {
            
            WebService.instance.playerGroup.enter()
            WebService.instance.getPlayerSeasonStats(playerID: self.playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                self._currentRegularSeasonAdvStats = AdvStats(classType: ClassType.Player, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: currentSeason)
                //print("Test: \(self.currentRegularSeasonAdvStats.pace), \(self.currentRegularSeasonAdvStats.trueShooting)")
                
                let allSeasonsDict = self.getAdvanceStatAverages(dictArray: allSeasons)
                
                if allSeasonsDict.count != 0 {
                    self._careerRegularSeasonAdvStats = AdvStats(classType: ClassType.Player, statType: measureType, statDuration: StatDuration.Career, dict: allSeasonsDict)
                } else {
                    print("Stats not available")
                }
                WebService.instance.playerGroup.leave()
            }
        }
        
        else if (measureType == MeasureType.PostAdvanced) {
            
            WebService.instance.playerGroup.enter()
            WebService.instance.getPlayerSeasonStats(playerID: self.playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                if currentSeason.count != 0 {
                    self._currentPostSeasonAdvStats = AdvStats(classType: ClassType.Player, statType: measureType, statDuration: StatDuration.CurrentSeason, dict: currentSeason)
                    //print("Test: \(self.currentPostSeasonAdvStats.pace), \(self.currentPostSeasonAdvStats.trueShooting)")
                } else {
                    print("The playoffs haven't started yet")
                }
                
                
                if (allSeasons.count != 0) {
                    self._careerPostSeasonAdvStats = AdvStats(classType: ClassType.Player, statType: measureType, statDuration: StatDuration.Career, dict: self.getAdvanceStatAverages(dictArray: allSeasons))
                }
                 else {
                    print("\(self.name) has never made the playoffs")
                }
                WebService.instance.playerGroup.leave()
            }
        }
        
        
    }
    
    func getPlayerStats(statDuration: StatDuration) {
        
        if statDuration == StatDuration.Career {
            
            WebService.instance.playerGroup.enter()
            WebService.instance.getPlayerCareerStats(playerID: self.playerID) { (regularSeasonStats, postSeasonStats) in
                
                if regularSeasonStats.count != 0 {
                    self._careerRegularSeasonTradStats = TradStats(classType: ClassType.Player, statType: MeasureType.RegularBase, statDuration: StatDuration.Career, dict: regularSeasonStats)
                    //print("CareerRegFG \(self._careerRegularSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("No Career Regular Season Stats available")
                }
                
                if postSeasonStats.count != 0 {
                    self._careerPostSeasonTradStats = TradStats(classType: ClassType.Player, statType: MeasureType.PostBase, statDuration: StatDuration.Career, dict: postSeasonStats)
                    //print("CareerPostFG \(self._careerPostSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("No Career Post Season Stats available")
                }
                WebService.instance.playerGroup.leave()
            }
            
        }
        
    }
    
    func getAdvanceStatAverages(dictArray: [AnyObject]) -> Dictionary<String, AnyObject> {
        
        var offRating: Float = 0
        var defRating: Float = 0
        var netRating: Float = 0
        var effectiveFG: Float = 0
        var trueShooting: Float = 0
        var usage: Float = 0
        var pace: Float = 0
        var PIE: Float = 0
        
        let count = Float(dictArray.count)
        
        for statsForYear in dictArray {
            
            offRating += Float(truncating: statsForYear["OFF_RATING"] as! NSNumber)
            defRating += Float(truncating: statsForYear["DEF_RATING"] as! NSNumber)
            netRating += Float(truncating: statsForYear["NET_RATING"] as! NSNumber)
            effectiveFG += Float(truncating: statsForYear["EFG_PCT"] as! NSNumber)
            trueShooting += Float(truncating: statsForYear["TS_PCT"] as! NSNumber)
            usage += Float(truncating: statsForYear["USG_PCT"] as! NSNumber)
            pace += Float(truncating: statsForYear["PACE"] as! NSNumber)
            PIE += Float(truncating: statsForYear["PIE"] as! NSNumber)
            
        }
        
        var careerAdvanceStats = Dictionary<String, AnyObject>()
        
        careerAdvanceStats.updateValue(offRating/count as AnyObject, forKey: "OFF_RATING")
        careerAdvanceStats.updateValue(defRating/count as AnyObject, forKey: "DEF_RATING")
        careerAdvanceStats.updateValue(netRating/count as AnyObject, forKey: "NET_RATING")
        careerAdvanceStats.updateValue(effectiveFG/count as AnyObject, forKey: "EFG_PCT")
        careerAdvanceStats.updateValue(trueShooting/count as AnyObject, forKey: "TS_PCT")
        careerAdvanceStats.updateValue(usage/count as AnyObject, forKey: "USG_PCT")
        careerAdvanceStats.updateValue(pace/count as AnyObject, forKey: "PACE")
        careerAdvanceStats.updateValue(PIE/count as AnyObject, forKey: "PIE")
        
        return careerAdvanceStats
        
    }
    
    func getCommonPlayerInfo() {
        
        WebService.instance.playerGroup.enter()
        WebService.instance.getCommonPlayerInfo(playerID: self.playerID) { (commonPlayerInfo) in
            
            if commonPlayerInfo.count != 0 {
            
                self._yearsExperience = commonPlayerInfo["SEASON_EXP"] as! Int
                self._currentTeam = "\(commonPlayerInfo["TEAM_CITY"] as! String) \(commonPlayerInfo["TEAM_NAME"] as! String)"
                self._startingYear = commonPlayerInfo["DRAFT_YEAR"] as! String
                
            }
            
            WebService.instance.playerGroup.leave()
        }
        
    }
    
}
