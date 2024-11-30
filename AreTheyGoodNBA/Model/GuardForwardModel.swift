//
//  GuardForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardForwardModel: PlayerModel {
    
    let TSMin = 0.451
    let TSFirst = 0.536
    let TSMed = 0.566
    let TSThird = 0.5895
    let TSMax = 0.631
    
    let ASTMin = 0.0292
    let ASTFirst = 0.06145
    let ASTMed = 0.09632
    let ASTThird = 0.11177
    let ASTMax = 0.26133
    
    let TRBMin = 0.08054
    let TRBFirst = 0.1158
    let TRBMed = 0.14458
    let TRBThird = 0.17519
    let TRBMax = 0.33054
    
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
    
    let TOVMin = 0.6693
    let TOVFirst = 0.3198
    let TOVMed = 0.2532
    let TOVThird = 0.2178
    let TOVMax = 0.1291
    
    let ORTGMin = 97.8
    let ORTGFirst = 108.5
    let ORTGMed = 113.5
    let ORTGThird = 116.6
    let ORTGMax = 121.9
    
    //reverse DRTG
    
    let DRTGMin = 121.4
    let DRTGFirst = 115.0
    let DRTGMed = 112.8
    let DRTGThird = 110.2
    let DRTGMax = 103.4
    
    let USGMin = 0.085
    let USGFirst = 0.132
    let USGMed = 0.161
    let USGThird = 0.216
    let USGMax = 0.355
    
    let PTMin = 0.2078
    let PTFirst = 0.2953
    let PTMed = 0.3812
    let PTThird = 0.5305
    let PTMax = 0.904
    
    
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
