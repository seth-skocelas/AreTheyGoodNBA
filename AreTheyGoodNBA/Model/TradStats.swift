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
    private var _minutesPlayed: Double!
    private var _threePointPercent: Double!
    private var _threePointPerMin: Double!
    private var _threePointAttempts: Double!
    private var _fieldGoalPercent: Double!
    private var _fieldGoalPerMin: Double!
    private var _fieldGoalAttempts: Double!
    private var _points: Double!
    private var _rebounds: Double!
    private var _assists: Double!
    private var _turnovers: Double!
    private var _plusMinus: Double!
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
    
    var minutesPlayed: Double {
        if _minutesPlayed == nil {
            return -1
        }
        return _minutesPlayed
    }
    
    var threePointPercent: Double {
        if _threePointPercent == nil {
            return -1
        }
        return _threePointPercent
    }
    
    var threePointPerMin: Double {
        if _threePointPerMin == nil {
            return -1
        }
        return _threePointPerMin
    }
    
    var threePointAttempts: Double {
        if _threePointAttempts == nil {
            return -1
        }
        return _threePointAttempts
    }
    
    var fieldGoalPercent: Double {
        if _fieldGoalPercent == nil {
            return -1
        }
        return _fieldGoalPercent
    }
    
    var fieldGoalPerMin: Double {
        if _fieldGoalPerMin == nil {
            return -1
        }
        return _fieldGoalPercent
    }
    
    var fieldGoalAttempts: Double {
        if _fieldGoalAttempts == nil {
            return -1
        }
        return _fieldGoalAttempts
    }
    
    var points: Double {
        if _points == nil {
            return -1
        }
        return _points
    }
    
    var rebounds: Double {
        if _rebounds == nil {
            return -1
        }
        return _rebounds
    }
    
    var assists: Double {
        if _assists == nil {
            return -1
        }
        return _assists
    }
    
    var turnovers: Double {
        if _turnovers == nil {
            return -1
        }
        return _turnovers
    }
    
    var plusMinus: Double {
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
            self._minutesPlayed = dict["MIN"]?.doubleValue as! Double
            self._threePointPercent = dict["FG3_PCT"]?.doubleValue as! Double
            self._threePointPerMin = dict["FG3M"]?.doubleValue as! Double
            self._threePointAttempts = dict["FG3A"]?.doubleValue as! Double
            self._fieldGoalPercent = dict["FG_PCT"]?.doubleValue as! Double
            self._fieldGoalPerMin = dict["FGM"]?.doubleValue as! Double
            self._fieldGoalAttempts = dict["FGA"]?.doubleValue as! Double
            self._points = dict["PTS"]?.doubleValue as! Double
            self._rebounds = dict["REB"]?.doubleValue as! Double
            self._assists = dict["AST"]?.doubleValue as! Double
            self._turnovers = dict["TOV"]?.doubleValue as! Double
            if statDuration == StatDuration.CurrentSeason {
                self._plusMinus = dict["PLUS_MINUS"]?.doubleValue as! Double
            }
            
        }
        
    }
    
}
