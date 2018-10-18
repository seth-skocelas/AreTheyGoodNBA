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
    
    private var _offRating: Double!
    private var _defRating: Double!
    private var _netRating: Double!
    private var _effectiveFG: Double!
    private var _trueShooting: Double!
    private var _usage: Double!
    private var _pace: Double!
    private var _PIE: Double!
    
    var isEmpty: Bool {
        return _isEmpty
    }
    
    var offRating: Double {
        if _offRating == nil {
            return -1000
        }
        return _offRating
    }
    
    var defRating: Double {
        if _defRating == nil {
            return -1000
        }
        return _defRating
    }
    
    var netRating: Double {
        if _netRating == nil {
            return -1000
        }
        return _netRating
    }
    
    var effectiveFG: Double {
        if _effectiveFG == nil {
            return -1000
        }
        return _effectiveFG
    }
    
    var trueShooting: Double {
        if _trueShooting == nil {
            return -1000
        }
        return _trueShooting
    }
    
    var usage: Double {
        if _usage == nil {
            return -1000
        }
        return _usage
    }
    
    var pace: Double {
        if _pace == nil {
            return -1000
        }
        return _pace
    }
    
    var PIE: Double {
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
            
            self._offRating = dict["OFF_RATING"]?.doubleValue
            self._defRating = dict["DEF_RATING"]?.doubleValue
            self._netRating = dict["NET_RATING"]?.doubleValue
            self._effectiveFG = dict["EFG_PCT"]?.doubleValue
            self._trueShooting = dict["TS_PCT"]?.doubleValue
            self._pace = dict["PACE"]?.doubleValue
            self._PIE = dict["PIE"]?.doubleValue
            
            if classType == ClassType.Player {
                self._usage = dict["USG_PCT"]?.doubleValue
            }
            
        }
        
    }
    
}
