//
//  WNBAGuardForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 9/29/24.
//  Copyright © 2024 Seth Skocelas. All rights reserved.
//

import Foundation

class WNBAGuardForwardModel: PlayerModel {
    
    let TSMin = 0.433
    let TSFirst = 0.477
    let TSMed = 0.522
    let TSThird = 0.5310
    let TSMax = 0.575
    
    let ASTMin = 0.04418
    let ASTFirst = 0.06289
    let ASTMed = 0.07006
    let ASTThird = 0.07438
    let ASTMax = 0.11798
    
    let TRBMin = 0.1146
    let TRBFirst = 0.124
    let TRBMed = 0.1393
    let TRBThird = 0.1575
    let TRBMax = 0.1887
    
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
    
    let TOVMin = 0.6726
    let TOVFirst = 0.3757
    let TOVMed = 0.3448
    let TOVThird = 0.2958
    let TOVMax = 0.2029
    
    let ORTGMin = 91.2
    let ORTGFirst = 98.6
    let ORTGMed = 99.4
    let ORTGThird = 102.3
    let ORTGMax = 110.2
    
    //reverse DRTG
    
    let DRTGMin = 107.1
    let DRTGFirst = 104.6
    let DRTGMed = 94.7
    let DRTGThird = 93.6
    let DRTGMax = 91.9
    
    let USGMin = 0.137
    let USGFirst = 0.142
    let USGMed = 0.18
    let USGThird = 0.2170
    let USGMax = 0.311
    
    let PTMin = 0.2191
    let PTFirst = 0.2810
    let PTMed = 0.3758
    let PTThird = 0.4291
    let PTMax = 0.6533
    
    
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
