//
//  TradStats.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/16/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class TradStats {
    
    var _isEmpty = true
    
    private var classType: ClassType!
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
    private var _points: Float!
    private var _rebounds: Float!
    private var _assists: Float!
    private var _turnovers: Float!
    private var _plusMinus: Float!
    // PlusMinus only available for current season (might be able to pull this if I pull year by year and average)
    
    var isEmpty: Bool {
        return _isEmpty
    }
    
    var gamesPlayed: Int {
        if _gamesPlayed == nil {
            return -1
        }
        return _gamesPlayed
    }
    
    var minutesPlayed: Float {
        if _minutesPlayed == nil {
            return -1
        }
        return _minutesPlayed
    }
    
    var threePointPercent: Float {
        if _threePointPercent == nil {
            return -1
        }
        return _threePointPercent
    }
    
    var threePointPerMin: Float {
        if _threePointPerMin == nil {
            return -1
        }
        return _threePointPerMin
    }
    
    var threePointAttempts: Float {
        if _threePointAttempts == nil {
            return -1
        }
        return _threePointAttempts
    }
    
    var fieldGoalPercent: Float {
        if _fieldGoalPercent == nil {
            return -1
        }
        return _fieldGoalPercent
    }
    
    var fieldGoalPerMin: Float {
        if _fieldGoalPerMin == nil {
            return -1
        }
        return _fieldGoalPercent
    }
    
    var fieldGoalAttempts: Float {
        if _fieldGoalAttempts == nil {
            return -1
        }
        return _fieldGoalAttempts
    }
    
    var points: Float {
        if _points == nil {
            return -1
        }
        return _points
    }
    
    var rebounds: Float {
        if _rebounds == nil {
            return -1
        }
        return _rebounds
    }
    
    var assists: Float {
        if _assists == nil {
            return -1
        }
        return _assists
    }
    
    var turnovers: Float {
        if _turnovers == nil {
            return -1
        }
        return _turnovers
    }
    
    var plusMinus: Float {
        if _plusMinus == nil {
            //-1 could be a legitimate value for plusminus, so I increased it to -100000, which wouldn't be
            return -100000
        }
        return _plusMinus
    }
    
    init() {}
    
    init(classType: ClassType, statType: MeasureType, statDuration: StatDuration, dict: Dictionary<String, AnyObject>) {
        
        if dict.count != 0 {
        
            self._isEmpty = false
            
            self._statType = statType
            self._statDuration = statDuration
            
            self._gamesPlayed = dict["GP"] as! Int
            self._minutesPlayed = dict["MIN"]?.floatValue as! Float
            self._threePointPercent = dict["FG3_PCT"]?.floatValue as! Float
            self._threePointPerMin = dict["FG3M"]?.floatValue as! Float
            self._threePointAttempts = dict["FG3A"]?.floatValue as! Float
            self._fieldGoalPercent = dict["FG_PCT"]?.floatValue as! Float
            self._fieldGoalPerMin = dict["FGM"]?.floatValue as! Float
            self._fieldGoalAttempts = dict["FGA"]?.floatValue as! Float
            self._points = dict["PTS"]?.floatValue as! Float
            self._rebounds = dict["REB"]?.floatValue as! Float
            self._assists = dict["AST"]?.floatValue as! Float
            self._turnovers = dict["TOV"]?.floatValue as! Float
            if statDuration == StatDuration.CurrentSeason {
                self._plusMinus = dict["PLUS_MINUS"]?.floatValue as! Float
            }
            
        }
        
    }
    
}
