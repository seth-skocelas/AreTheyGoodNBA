//
//  CenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/11/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class CenterModel: PlayerModel {
    
    
    
    let TSMin = 0.4770
    let TSFirst = 0.5753
    let TSMed = 0.6090
    let TSThird = 0.6522
    let TSMax = 0.7630
    
    //Assist per min
    
    let ASTMin = 0.02924
    let ASTFirst = 0.05015
    let ASTMed = 0.07902
    let ASTThird = 0.09336
    let ASTMax = 0.26012
    
    //Total Rebounds per min
    
    let TRBMin = 0.1705
    let TRBFirst = 0.3104
    let TRBMed = 0.3455
    let TRBThird = 0.3946
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
    let TOVFirst = 0.3598
    let TOVMed = 0.2964
    let TOVThird = 0.2671
    let TOVMax = 0.2002
    
    let ORTGMin = 94.0
    let ORTGFirst = 108.2
    let ORTGMed = 114.3
    let ORTGThird = 116.9
    let ORTGMax = 122.4
    
    //reverse DRTG
    
    let DRTGMin = 118.9
    let DRTGFirst = 115.0
    let DRTGMed = 113.0
    let DRTGThird = 110.8
    let DRTGMax = 100.8
    
    let USGMin = 0.1060
    let USGFirst = 0.1497
    let USGMed = 0.166
    let USGThird = 0.1985
    let USGMax = 0.288
    
    let PTMin = 0.2222
    let PTFirst = 0.378
    let PTMed = 0.4155
    let PTThird = 0.5094
    let PTMax = 0.763
    
    
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
