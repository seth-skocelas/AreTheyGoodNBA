//
//  PlayerTradStats.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/16/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class PlayerTradStats {
    
    private var _statType: MeasureType!
    private var _statDuration: StatDuration!
    
    private var _gamesPlayed: Int!
    private var _minutesPlayed: Float!
    private var _threePointPercent: Float!
    private var _threePointPerMin: Float!
    private var _threePointAttempts: Float!
    private var _fieldGoalPercent: Float!
    private var _fieldGoalPerMin: Float!
    private var _fieldGoalAttempts: Float!
    private var _rebounds: Float!
    private var _assists: Float!
    private var _turnovers: Float!
    private var _plusMinus: Float!
    // PlusMinus only available for current season (might be able to pull this if I pull year by year and average)
    
    var gamesPlayed: Int {
        if _gamesPlayed == nil {
            return -1
        }
        return _gamesPlayed
    }
    
    var fieldGoalPercent: Float {
        if _fieldGoalPercent == nil {
            return -1
        }
        return _fieldGoalPercent
    }
    
    
    init(statType: MeasureType, statDuration: StatDuration, dict: Dictionary<String, AnyObject>) {
        
        self._statType = statType
        self._statDuration = statDuration
        
        self._gamesPlayed = dict["GP"] as! Int
        self._minutesPlayed = dict["MIN"] as! Float
        self._threePointPercent = dict["FG3_PCT"] as! Float
        self._threePointPerMin = dict["FG3M"] as! Float
        self._threePointAttempts = dict["FG3A"] as! Float
        self._fieldGoalPercent = dict["FG_PCT"] as! Float
        self._fieldGoalPerMin = dict["FGM"] as! Float
        self._fieldGoalAttempts = dict["FGA"] as! Float
        self._rebounds = dict["REB"] as! Float
        self._assists = dict["AST"] as! Float
        self._turnovers = dict["TOV"] as! Float
        if statDuration == StatDuration.CurrentSeason {
            self._plusMinus = dict["PLUS_MINUS"] as! Float
        }
        
    }
    
}
