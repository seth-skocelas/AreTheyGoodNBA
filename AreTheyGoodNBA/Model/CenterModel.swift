//
//  CenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/11/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class CenterModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.4800
    let TSFirst = 0.5430
    let TSMed = 0.5860
    let TSThird = 0.6310
    let TSMax = 0.7270
    
    //Assist per min
    
    let ASTMin = 0.02837
    let ASTFirst = 0.04717
    let ASTMed = 0.05660
    let ASTThird = 0.08555
    let ASTMax = 0.21795
    
    //Total Rebounds per min
    
    let TRBMin = 0.1871
    let TRBFirst = 0.2837
    let TRBMed = 0.3269
    let TRBThird = 0.4145
    let TRBMax = 0.4749
    
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
    
    let TOVMin = 0.5145
    let TOVFirst = 0.3853
    let TOVMed = 0.3288
    let TOVThird = 0.2830
    let TOVMax = 0.1537
    
    
    let ORTGMin = 95.5
    let ORTGFirst = 102.7
    let ORTGMed = 107.6
    let ORTGThird = 111.4
    let ORTGMax = 126.0
    
    //reverse DRTG
    
    let DRTGMin = 117.1
    let DRTGFirst = 108.6
    let DRTGMed = 106.0
    let DRTGThird = 102.1
    let DRTGMax = 98.3
    
    let USGMin = 0.0910
    let USGFirst = 0.1510
    let USGMed = 0.1710
    let USGThird = 0.1930
    let USGMax = 0.2520
    
    let PTMin = 0.1847
    let PTFirst = 0.3782
    let PTMed = 0.4182
    let PTThird = 0.4882
    let PTMax = 0.5659
    
    
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
