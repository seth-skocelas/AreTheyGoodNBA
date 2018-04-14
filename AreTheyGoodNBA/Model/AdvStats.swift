//
//  AdvStats.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/22/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class AdvStats {
    
    private var _isEmpty = true
    
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
    
    var isEmpty: Bool {
        return _isEmpty
    }
    
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
    
    init() {}
    
    init(classType: ClassType, statType: MeasureType, statDuration: StatDuration, dict: Dictionary<String, AnyObject>) {
        
        if dict.count != 0 {
        
            self._isEmpty = false
            
            self._statType = statType
            self._statDuration = statDuration
            
            self._offRating = dict["OFF_RATING"]?.floatValue as! Float
            self._defRating = dict["DEF_RATING"]?.floatValue as! Float
            self._netRating = dict["NET_RATING"]?.floatValue as! Float
            self._effectiveFG = dict["EFG_PCT"]?.floatValue as! Float
            self._trueShooting = dict["TS_PCT"]?.floatValue as! Float
            self._pace = dict["PACE"]?.floatValue as! Float
            self._PIE = dict["PIE"]?.floatValue as! Float
            
            if classType == ClassType.Player {
                self._usage = dict["USG_PCT"]?.floatValue as! Float
            }
            
        }
        
    }
    
}
