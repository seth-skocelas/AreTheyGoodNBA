//
//  WNBACenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 9/29/24.
//  Copyright © 2024 Seth Skocelas. All rights reserved.
//

import Foundation

class WNBACenterModel: PlayerModel {
    
    
    
    let TSMin = 0.417
    let TSFirst = 0.5465
    let TSMed = 0.591
    let TSThird = 0.6165
    let TSMax = 0.645
    
    //Assist per min
    
    let ASTMin = 0.01695
    let ASTFirst = 0.04306
    let ASTMed = 0.06204
    let ASTThird = 0.07879
    let ASTMax = 0.10702
    
    //Total Rebounds per min
    
    let TRBMin = 0.1776
    let TRBFirst = 0.2209
    let TRBMed = 0.2554
    let TRBThird = 0.2986
    let TRBMax = 0.3459
    
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
    
    let TOVMin = 0.5023
    let TOVFirst = 0.4238
    let TOVMed = 0.3906
    let TOVThird = 0.2716
    let TOVMax = 0.1219
    
    let ORTGMin = 94.0
    let ORTGFirst = 97.1
    let ORTGMed = 101.6
    let ORTGThird = 103.5
    let ORTGMax = 107.8
    
    //reverse DRTG
    
    let DRTGMin = 109.9
    let DRTGFirst = 103.05
    let DRTGMed = 100.5
    let DRTGThird = 96.0
    let DRTGMax = 90.2
    
    let USGMin = 0.051
    let USGFirst = 0.1420
    let USGMed = 0.160
    let USGThird = 0.1935
    let USGMax = 0.31
    
    let PTMin = 0.07609
    let PTFirst = 0.34221
    let PTMed = 0.36296
    let PTThird = 0.4696
    let PTMax = 0.78198
    
    
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
        let partThree = Double(trbScore) * 0.2
        let partFour = Double((astScore + tovScore)/2) * 0.05
        let partFive = Double(ptScore) * 0.2
        
        statsScore = (partOne + partTwo + partThree + partFour + partFive)/3
        print ("Total score: \(statsScore)")
        calculateResult()
        
        
    }

}
