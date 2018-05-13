//
//  ForwardCenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class ForwardCenterModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.4750
    let TSFirst = 0.5613
    let TSMed = 0.5827
    let TSThird = 0.6052
    let TSMax = 0.6630
    
    //Assist per min
    
    let ASTMin = 0.02962
    let ASTFirst = 0.04793
    let ASTMed = 0.05997
    let ASTThird = 0.08714
    let ASTMax = 0.18747
    
    //Total Rebounds per min
    
    let TRBMin = 0.1372
    let TRBFirst = 0.2326
    let TRBMed = 0.2642
    let TRBThird = 0.3015
    let TRBMax = 0.3552
    
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
    
    let TOVMin = 0.4367
    let TOVFirst = 0.3565
    let TOVMed = 0.2633
    let TOVThird = 0.2215
    let TOVMax = 0.1520
    
    
    let ORTGMin = 93.0
    let ORTGFirst = 110.0
    let ORTGMed = 114.5
    let ORTGThird = 119.0
    let ORTGMax = 129.0
    
    //reverse DRTG
    
    let DRTGMin = 113.0
    let DRTGFirst = 110.0
    let DRTGMed = 107.0
    let DRTGThird = 105.0
    let DRTGMax = 102.0
    
    let USGMin = 0.1260
    let USGFirst = 0.1550
    let USGMed = 0.1870
    let USGThird = 0.2243
    let USGMax = 0.3190
    
    
    override init(player: Player, statDuration: StatDuration) {
        
        super.init(player: player, statDuration: statDuration)
        
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
        let partThree = Double((astScore + tovScore)/2) * 0.1
        let partFour = Double(trbScore) * 0.2
        statsScore = (partOne + partTwo + partThree + partFour)/3
        print ("Total score: \(statsScore)")
        
        
    }

}
