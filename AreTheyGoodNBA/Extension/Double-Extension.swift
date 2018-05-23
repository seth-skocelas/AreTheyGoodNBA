//
//  Double-Extension.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/23/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

extension Double {
    
    var oneDecimalString: String {
        return String(format: "%.1f", self)
    }
    
    var threeDecimalString: String {
        return String(format: "%.3f", self)
    }
    
}
