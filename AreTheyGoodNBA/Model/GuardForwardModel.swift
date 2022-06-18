//
//  GuardForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardForwardModel: PlayerModel {
    
    let TSMin = 0.433
    let TSFirst = 0.515
    let TSMed = 0.543
    let TSThird = 0.5713
    let TSMax = 0.66
    
    let ASTMin = 0.02484
    let ASTFirst = 0.05424
    let ASTMed = 0.06802
    let ASTThird = 0.09646
    let ASTMax = 0.24576
    
    let TRBMin = 0.07714
    let TRBFirst = 0.12456
    let TRBMed = 0.14719
    let TRBThird = 0.19185
    let TRBMax = 0.27179
    
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
    
    let TOVMin = 0.4144
    let TOVFirst = 0.2763
    let TOVMed = 0.2466
    let TOVThird = 0.2062
    let TOVMax = 0.1223
    
    let ORTGMin = 96.6
    let ORTGFirst = 105.6
    let ORTGMed = 108.8
    let ORTGThird = 112.3
    let ORTGMax = 116.9
    
    //reverse DRTG
    
    let DRTGMin = 116.8
    let DRTGFirst = 112.4
    let DRTGMed = 109.8
    let DRTGThird = 106.3
    let DRTGMax = 97.0
    
    let USGMin = 0.095
    let USGFirst = 0.1358
    let USGMed = 0.161
    let USGThird = 0.202
    let USGMax = 0.368
    
    let PTMin = 0.2062
    let PTFirst = 0.3086
    let PTMed = 0.378
    let PTThird = 0.4784
    let PTMax = 0.8023
    
    
    override init(player: Player, statDuration: StatDuration, isSecondary: Bool) {
        
        super.init(player: player, statDuration: statDuration, isSecondary: isSecondary)
        
        calculateScore()
        
    }
    
    func calculateScore() {
    
        var tovScore = 0
        
        let tsScore = calculateHighStatScore(stat: playerRegularAdvStats.trueShooting, first: TSFirst, median: TSMed, third: TSThird)
        print("Player Stat: \(playerRegularAdvStats.trueShooting) - Player Score: \(tsScore)")
        scoreDict.updateValue(tsScore, forKey: "true shooting percentage")
        
        let ptMin = playerRegularTradStats.points/playerRegularTradStats.minutesPlayed
        
        let ptScore = calculateHighStatScore(stat: ptMin, first: PTFirst, median: PTMed, third: PTThird)
        print("Player Stat: \(ptMin) - Player Score: \(ptScore)")
        scoreDict.updateValue(ptScore, forKey: "points scored")
        
        let ortgScore = calculateHighStatScore(stat: playerRegularAdvStats.offRating, first: ORTGFirst, median: ORTGMed, third: ORTGThird)
        print("Player Stat: \(playerRegularAdvStats.offRating) - Player Score: \(ortgScore)")
        scoreDict.updateValue(ortgScore, forKey: "offensive rating")
        
        let drtgScore = calculateLowStatScore(stat: playerRegularAdvStats.defRating, first: DRTGFirst, median: DRTGMed, third: DRTGThird)
        print("Player Stat: \(playerRegularAdvStats.defRating) - Player Score: \(drtgScore)")
        scoreDict.updateValue(drtgScore, forKey: "defensive rating")
        
        let astMin = (playerRegularTradStats.assists)/(playerRegularTradStats.minutesPlayed)
        
        let astScore = calculateHighStatScore(stat: astMin, first: ASTFirst, median: ASTMed, third: ASTThird)
        print("Player Stat: \(astMin) - Player Score: \(astScore)")
        scoreDict.updateValue(astScore, forKey: "assist rate")
        
        let trbMin = playerRegularTradStats.rebounds/playerRegularTradStats.minutesPlayed
        
        let trbScore = calculateHighStatScore(stat: trbMin, first: TRBFirst, median: TRBMed, third: TRBThird)
        print("Player Stat: \(trbMin) - Player Score: \(trbScore)")
        scoreDict.updateValue(trbScore, forKey: "rebound rate")
        
        let tovMin = (playerRegularTradStats.turnovers/playerRegularTradStats.minutesPlayed)/playerRegularAdvStats.usage
        
        if playerRegularAdvStats.usage >= USGThird {
            tovScore = 3
            print("High usage bonus")
        } else {
            tovScore = calculateLowStatScore(stat: tovMin, first: TOVFirst, median: TOVMed, third: TOVThird)
            print("Player Stat: \(tovMin) - Player Score: \(tovScore)")
            scoreDict.updateValue(tovScore, forKey: "turnover rate")
        }
        
        let partOne = Double(tsScore) * 0.25
        let partTwo = Double((ortgScore + drtgScore)/2) * 0.3
        let partThree = Double((astScore + tovScore)/2) * 0.15
        let partFour = Double(trbScore) * 0.1
        let partFive = Double(ptScore) * 0.2
        
        statsScore = (partOne + partTwo + partThree + partFour + partFive)/3
        print ("Total score: \(statsScore)")
        calculateResult()
        
        
    }

}
