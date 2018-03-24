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
    private var _height: String!
    private var _weight: String!
    private var _yearsExperience: Int!
    private var _jerseyNumber: String!
    private var _position: String!
    private var _currentTeam: String!
    private var _startingYear: String!
    
    private var _currentRegularSeasonTradStats: PlayerTradStats!
    private var _currentPostSeasonTradStats: PlayerTradStats!
    private var _careerRegularSeasonTradStats: PlayerTradStats!
    private var _careerPostSeasonTradStats: PlayerTradStats!
    
    private var _currentRegularSeasonAdvStats: PlayerAdvStats!
    private var _currentPostSeasonAdvStats: PlayerAdvStats!
    private var _careerRegularSeasonAdvStats: PlayerAdvStats!
    private var _careerPostSeasonAdvStats: PlayerAdvStats!
    
    var name: String {
        return _name
    }
    
    var playerID: Int {
        return _playerID
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
    
    var currentRegularSeasonTradStats: PlayerTradStats {
        return _currentRegularSeasonTradStats
    }
    
    var currentPostSeasonTradStats: PlayerTradStats {
        return _currentPostSeasonTradStats
    }
    
    var careerRegularSeasonTradStats: PlayerTradStats {
        return _careerRegularSeasonTradStats
    }
    
    var careerPostSeasonTradStats: PlayerTradStats {
        return _careerPostSeasonTradStats
    }
    
    var currentRegularSeasonAdvStats: PlayerAdvStats {
        return _currentRegularSeasonAdvStats
    }
    
    var currentPostSeasonAdvStats: PlayerAdvStats {
        return _currentPostSeasonAdvStats
    }
    
    var careerRegularSeasonAdvStats: PlayerAdvStats {
        return _careerRegularSeasonAdvStats
    }
    
    var careerPostSeasonAdvStats: PlayerAdvStats {
        return _careerPostSeasonAdvStats
    }
    
    
    //Get data from nba.com API dictionary
    init(commonPlayerInfo: Dictionary<String, AnyObject>) {
        
        _name = commonPlayerInfo["DISPLAY_FIRST_LAST"] as! String
        _playerID = commonPlayerInfo["PERSON_ID"] as! Int
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
        _playerID = commonPlayerInfo["PLAYER_ID"] as! Int
        _height = commonPlayerInfo["HEIGHT"] as! String
        _weight = commonPlayerInfo["WEIGHT"] as! String
        _jerseyNumber = commonPlayerInfo["NUM"] as! String
        _position = commonPlayerInfo["POSITION"] as! String
        
    }
    
    func getAllStats() {
        
        getPlayerStats(measureType: MeasureType.RegularBase, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(measureType: MeasureType.PostBase, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(statDuration: StatDuration.Career)
        
        getPlayerStats(measureType: MeasureType.RegularAdvanced, statDuration: StatDuration.CurrentSeason)
        getPlayerStats(measureType: MeasureType.PostAdvanced, statDuration: StatDuration.CurrentSeason)
        
    }
    
    func getPlayerStats(measureType: MeasureType, statDuration: StatDuration) {
        
        if (measureType == MeasureType.RegularBase && statDuration == StatDuration.CurrentSeason) {
            
            WebService.instance.getPlayerSeasonStats(playerID: self._playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                self._currentRegularSeasonTradStats = PlayerTradStats(statType: measureType, statDuration: statDuration, dict: currentSeason)
                //print("Test: \(self.currentRegularSeasonTradStats.gamesPlayed), \(self.currentRegularSeasonTradStats.fieldGoalPercent)")
                
                
            }
        }
        
        else if (measureType == MeasureType.PostBase && statDuration == StatDuration.CurrentSeason) {
            
            WebService.instance.getPlayerSeasonStats(playerID: self._playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                if currentSeason.count != 0 {
                    self._currentPostSeasonTradStats = PlayerTradStats(statType: measureType, statDuration: statDuration, dict: currentSeason)
                    //print("Test: \(self.currentPostSeasonTradStats.gamesPlayed), \(self.currentPostSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("The playoffs haven't started yet")
                }
                
            }
        }
        
        else if (measureType == MeasureType.RegularAdvanced) {
            
            WebService.instance.getPlayerSeasonStats(playerID: self._playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                self._currentRegularSeasonAdvStats = PlayerAdvStats(statType: measureType, statDuration: StatDuration.CurrentSeason, dict: currentSeason)
                print("Test: \(self.currentRegularSeasonAdvStats.pace), \(self.currentRegularSeasonAdvStats.trueShooting)")
                
                let allSeasonsDict = self.getAdvanceStatAverages(dictArray: allSeasons)
                
                if allSeasonsDict.count != 0 {
                    self._careerRegularSeasonAdvStats = PlayerAdvStats(statType: measureType, statDuration: StatDuration.Career, dict: allSeasonsDict)
                } else {
                    print("Stats not available")
                }
            }
        }
        
        else if (measureType == MeasureType.PostAdvanced) {
            
            WebService.instance.getPlayerSeasonStats(playerID: self._playerID, measureType: measureType) { (currentSeason, allSeasons) in
                
                if currentSeason.count != 0 {
                    self._currentPostSeasonAdvStats = PlayerAdvStats(statType: measureType, statDuration: StatDuration.CurrentSeason, dict: currentSeason)
                    print("Test: \(self.currentPostSeasonAdvStats.pace), \(self.currentPostSeasonAdvStats.trueShooting)")
                } else {
                    print("The playoffs haven't started yet")
                }
                
                
                if (allSeasons.count != 0) {
                    self._careerPostSeasonAdvStats = PlayerAdvStats(statType: measureType, statDuration: StatDuration.Career, dict: self.getAdvanceStatAverages(dictArray: allSeasons))
                }
                 else {
                    print("\(self.name) has never made the playoffs")
                }
                
            }
        }
        
        
    }
    
    func getPlayerStats(statDuration: StatDuration) {
        
        if statDuration == StatDuration.Career {
            
            WebService.instance.getPlayerCareerStats(playerID: self.playerID) { (regularSeasonStats, postSeasonStats) in
                
                if regularSeasonStats.count != 0 {
                    self._careerRegularSeasonTradStats = PlayerTradStats(statType: MeasureType.RegularBase, statDuration: StatDuration.Career, dict: regularSeasonStats)
                    //print("CareerRegFG \(self._careerRegularSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("No Career Regular Season Stats available")
                }
                
                if postSeasonStats.count != 0 {
                    self._careerPostSeasonTradStats = PlayerTradStats(statType: MeasureType.PostBase, statDuration: StatDuration.Career, dict: postSeasonStats)
                    //print("CareerPostFG \(self._careerPostSeasonTradStats.fieldGoalPercent)")
                } else {
                    print("No Career Post Season Stats available")
                }
                
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
            
            offRating += statsForYear["OFF_RATING"] as! Float
            defRating += statsForYear["DEF_RATING"] as! Float
            netRating += statsForYear["NET_RATING"] as! Float
            effectiveFG += statsForYear["EFG_PCT"] as! Float
            trueShooting += statsForYear["TS_PCT"] as! Float
            usage += statsForYear["USG_PCT"] as! Float
            pace += statsForYear["PACE"] as! Float
            PIE += statsForYear["PIE"] as! Float
            
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
        
        print(careerAdvanceStats)
        
        return careerAdvanceStats
        
    }
    
}
