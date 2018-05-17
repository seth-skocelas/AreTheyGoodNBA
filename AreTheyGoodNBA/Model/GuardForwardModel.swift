//
//  GuardForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardForwardModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.4440
    let TSFirst = 0.5317
    let TSMed = 0.5575
    let TSThird = 0.5820
    let TSMax = 0.6520
    
    //Assist per min
    
    let ASTMin = 0.02469
    let ASTFirst = 0.05337
    let ASTMed = 0.06561
    let ASTThird = 0.12734
    let ASTMax = 0.24686
    
    //Total Rebounds per min
    
    let TRBMin = 0.06868
    let TRBFirst = 0.10982
    let TRBMed = 0.13926
    let TRBThird = 0.16033
    let TRBMax = 0.27322
    
    /* Currently not getting steals, might add this later.
     
     let STLMin = 12.0
     let STLFirst = 35.0
     let STLMed = 57.0
     let STLThird = 79.0
     let STLMax = 177.0
     */
    
    //reverse TOV
    /*
     let TOVMin = 0.13075
     let TOVFirst = 0.07645
     let TOVMed = 0.05805
     let TOVThird = 0.04723
     let TOVMax = 0.02086
     */
    
    //TOV based on usage
    
    let TOVMin = 0.4563
    let TOVFirst = 0.3185
    let TOVMed = 0.2561
    let TOVThird = 0.2122
    let TOVMax = 0.1308
    
    
    let ORTGMin = 84.0
    let ORTGFirst = 103.0
    let ORTGMed = 109.0
    let ORTGThird = 113.8
    let ORTGMax = 122.0
    
    //reverse DRTG
    
    let DRTGMin = 115.0
    let DRTGFirst = 112.0
    let DRTGMed = 110.0
    let DRTGThird = 108.0
    let DRTGMax = 101.0
    
    let USGMin = 0.1060
    let USGFirst = 0.1575
    let USGMed = 0.2030
    let USGThird = 0.2312
    let USGMax = 0.3160
    
    
    override init(player: Player, statDuration: StatDuration, isSecondary: Bool) {
        
        super.init(player: player, statDuration: statDuration, isSecondary: isSecondary)
        
        calculateScore()
        
    }
    
    func calculateScore() {
    
        var tovScore = 0
        
        let tsScore = calculateHighStatScore(stat: playerRegularAdvStats.trueShooting, first: TSFirst, median: TSMed, third: TSThird)
        print("Player Stat: \(playerRegularAdvStats.trueShooting) - Player Score: \(tsScore)")
        
        let ortgScore = calculateHighStatScore(stat: playerRegularAdvStats.offRating, first: ORTGFirst, median: ORTGMed, third: ORTGThird)
        print("Player Stat: \(playerRegularAdvStats.offRating) - Player Score: \(ortgScore)")
        
        let drtgScore = calculateLowStatScore(stat: playerRegularAdvStats.defRating, first: DRTGFirst, median: DRTGMed, third: DRTGThird)
        print("Player Stat: \(playerRegularAdvStats.defRating) - Player Score: \(drtgScore)")
        
        let astMin = (playerRegularTradStats.assists)/(playerRegularTradStats.minutesPlayed)
        
        let astScore = calculateHighStatScore(stat: astMin, first: ASTFirst, median: ASTMed, third: ASTThird)
        print("Player Stat: \(astMin) - Player Score: \(astScore)")
        
        let trbMin = playerRegularTradStats.rebounds/playerRegularTradStats.minutesPlayed
        
        let trbScore = calculateHighStatScore(stat: trbMin, first: TRBFirst, median: TRBMed, third: TRBThird)
        print("Player Stat: \(trbMin) - Player Score: \(trbScore)")
        
        let tovMin = (playerRegularTradStats.turnovers/playerRegularTradStats.minutesPlayed)/playerRegularAdvStats.usage
        
        if playerRegularAdvStats.usage >= USGThird {
            tovScore = 3
            print("High usage bonus")
        } else {
            tovScore = calculateLowStatScore(stat: tovMin, first: TOVFirst, median: TOVMed, third: TOVThird)
            print("Player Stat: \(tovMin) - Player Score: \(tovScore)")
        }
        
        let partOne = Double(tsScore) * 0.4
        let partTwo = Double((ortgScore + drtgScore)/2) * 0.3
        let partThree = Double((astScore + tovScore)/2) * 0.2
        let partFour = Double(trbScore) * 0.1
        statsScore = (partOne + partTwo + partThree + partFour)/3
        print ("Total score: \(statsScore)")
        calculateResult()
        
        
    }

}
