//
//  AdvStats.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/22/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class AdvStats {
    
    private var classType: ClassType!
    private var _statType: MeasureType!
    private var _statDuration: StatDuration!
    
    private var _offRating: Float!
    private var _defRating: Float!
    private var _netRating: Float!
    private var _effectiveFG: Float!
    private var _trueShooting: Float!
    private var _usage: Float!
    private var _pace: Float!
    private var _PIE: Float!
    
    var offRating: Float {
        if _offRating == nil {
            return -1000
        }
        return _offRating
    }
    
    var defRating: Float {
        if _defRating == nil {
            return -1000
        }
        return _defRating
    }
    
    var netRating: Float {
        if _netRating == nil {
            return -1000
        }
        return _netRating
    }
    
    var effectiveFG: Float {
        if _effectiveFG == nil {
            return -1000
        }
        return _effectiveFG
    }
    
    var trueShooting: Float {
        if _trueShooting == nil {
            return -1000
        }
        return _trueShooting
    }
    
    var usage: Float {
        if _usage == nil {
            return -1000
        }
        return _usage
    }
    
    var pace: Float {
        if _pace == nil {
            return -1000
        }
        return _pace
    }
    
    var PIE: Float {
        if _PIE == nil {
            return -1000
        }
        return _PIE
    }
    
    
    init(classType: ClassType, statType: MeasureType, statDuration: StatDuration, dict: Dictionary<String, AnyObject>) {
        
        self._statType = statType
        self._statDuration = statDuration
        
        self._offRating = dict["OFF_RATING"] as! Float
        self._defRating = dict["DEF_RATING"] as! Float
        self._netRating = dict["NET_RATING"] as! Float
        self._effectiveFG = dict["EFG_PCT"] as! Float
        self._trueShooting = dict["TS_PCT"] as! Float
        self._pace = dict["PACE"] as! Float
        self._PIE = dict["PIE"] as! Float
        
        if classType == ClassType.Player {
            self._usage = dict["USG_PCT"] as! Float
        }
        
    }
    
}
