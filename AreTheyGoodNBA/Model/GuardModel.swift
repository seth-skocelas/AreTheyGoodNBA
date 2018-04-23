//
//  GuardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardModel: Model {
    
    let TSMin = 0.4210
    let TSFirst = 0.5030
    let TSMed = 0.5356
    let TSThird = 0.5633
    let TSMax = 0.6750
    
    let ASTMin = 25
    let ASTFirst = 122
    let ASTMed = 200
    let ASTThird = 307
    let ASTMax = 820
    
    let TRBMin = 66
    let TRBFirst = 127
    let TRBMed = 179
    let TRBThird = 259
    let TRBMax = 804
    
    let STLMin = 12
    let STLFirst = 35
    let STLMed = 57
    let STLThird = 79
    let STLMax = 177
    
    let TOVMin = 66
    let TOVFirst = 127
    let TOVMed = 179
    let TOVThird = 259
    let TOVMax = 804
    
    let ORTGMin = 89
    let ORTGFirst = 101
    let ORTGMed = 106
    let ORTGThird = 111
    let ORTGMax = 126
    
    let DRTGMin = 101
    let DRTGFirst = 109
    let DRTGMed = 110
    let DRTGThird = 112
    let DRTGMax = 117
    
    let USGMin = 0.1130
    let USGFirst = 0.1218
    let USGMed = 0.1960
    let USGThird = 0.2455
    let USGMax = 0.3610
    
    var testPlayer: Player
    
    init(player: Player) {
        
        self.testPlayer = player
        
    }
    
    func calculateScore() {
        
        var score = 0
        
        var tsScore = 0
        var ts = 0.0
        
        if self.testStatDuration == StatDuration.CurrentSeason {
            ts = testPlayer.currentRegularSeasonAdvStats.trueShooting
        } else {
            ts = testPlayer.careerRegularSeasonAdvStats.trueShooting
        }
        
//        if ts >= TSThird {
//            tsScore = 3
//        } else if
        
        
    }
    
    
    
    

}
