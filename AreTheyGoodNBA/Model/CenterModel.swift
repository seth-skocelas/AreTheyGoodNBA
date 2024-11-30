//
//  CenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/11/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class CenterModel: PlayerModel {
    
    
    
    let TSMin = 0.477
    let TSFirst = 0.5805
    let TSMed = 0.6145
    let TSThird = 0.6597
    let TSMax = 0.728
    
    //Assist per min
    
    let ASTMin = 0.02924
    let ASTFirst = 0.04673
    let ASTMed = 0.05692
    let ASTThird = 0.09020
    let ASTMax = 0.26012
    
    //Total Rebounds per min
    
    let TRBMin = 0.1705
    let TRBFirst = 0.2831
    let TRBMed = 0.3244
    let TRBThird = 0.3751
    let TRBMax = 0.5263
    
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
    
    let TOVMin = 0.5659
    let TOVFirst = 0.3767
    let TOVMed = 0.3088
    let TOVThird = 0.2727
    let TOVMax = 0.1468
    
    let ORTGMin = 94.0
    let ORTGFirst = 107.8
    let ORTGMed = 112.7
    let ORTGThird = 115.5
    let ORTGMax = 128.7
    
    //reverse DRTG
    
    let DRTGMin = 118.9
    let DRTGFirst = 115.8
    let DRTGMed = 113.3
    let DRTGThird = 110.4
    let DRTGMax = 100.8
    
    let USGMin = 0.06
    let USGFirst = 0.146
    let USGMed = 0.161
    let USGThird = 0.1933
    let USGMax = 0.288
    
    let PTMin = 0.1538
    let PTFirst = 0.3677
    let PTMed = 0.4105
    let PTThird = 0.4955
    let PTMax = 0.8163
    
    
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
