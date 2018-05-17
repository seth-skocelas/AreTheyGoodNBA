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
    
    let TSMin = 0.5020
    let TSFirst = 0.5550
    let TSMed = 0.5990
    let TSThird = 0.6300
    let TSMax = 0.6620
    
    //Assist per min
    
    let ASTMin = 0.03343
    let ASTFirst = 0.04629
    let ASTMed = 0.05837
    let ASTThird = 0.07262
    let ASTMax = 0.12666
    
    //Total Rebounds per min
    
    let TRBMin = 0.1695
    let TRBFirst = 0.2748
    let TRBMed = 0.3302
    let TRBThird = 0.3822
    let TRBMax = 0.4831
    
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
    
    let TOVMin = 0.5598
    let TOVFirst = 0.3594
    let TOVMed = 0.3207
    let TOVThird = 0.2731
    let TOVMax = 0.2287
    
    
    let ORTGMin = 102.0
    let ORTGFirst = 107.0
    let ORTGMed = 113.0
    let ORTGThird = 122.0
    let ORTGMax = 126.0
    
    //reverse DRTG
    
    let DRTGMin = 114.0
    let DRTGFirst = 108.0
    let DRTGMed = 105.0
    let DRTGThird = 101.0
    let DRTGMax = 99.0
    
    let USGMin = 0.1480
    let USGFirst = 0.167
    let USGMed = 0.1920
    let USGThird = 0.2350
    let USGMax = 0.3340
    
    
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
        let partThree = Double(trbScore) * 0.25
        let partFour = Double((astScore + tovScore)/2) * 0.05
        
        statsScore = (partOne + partTwo + partThree + partFour)/3
        print ("Total score: \(statsScore)")
        calculateResult()
        
        
    }

}
