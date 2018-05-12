//
//  ForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class ForwardModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.4800
    let TSFirst = 0.5360
    let TSMed = 0.5500
    let TSThird = 0.5820
    let TSMax = 0.6380
    
    //Assist per min
    
    let ASTMin = 0.02719
    let ASTFirst = 0.04393
    let ASTMed = 0.05771
    let ASTThird = 0.07081
    let ASTMax = 0.22213
    
    //Total Rebounds per min
    
    let TRBMin = 0.08436
    let TRBFirst = 0.15787
    let TRBMed = 0.19403
    let TRBThird = 0.23053
    let TRBMax = 0.39089
    
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
    
    let TOVMin = 0.5135
    let TOVFirst = 0.2898
    let TOVMed = 0.2482
    let TOVThird = 0.2078
    let TOVMax = 0.1309
    
    
    let ORTGMin = 95.0
    let ORTGFirst = 105.0
    let ORTGMed = 109.0
    let ORTGThird = 114.0
    let ORTGMax = 123.0
    
    //reverse DRTG
    
    let DRTGMin = 115.0
    let DRTGFirst = 111.0
    let DRTGMed = 109.0
    let DRTGThird = 107.0
    let DRTGMax = 103.0
    
    let USGMin = 0.1050
    let USGFirst = 0.1470
    let USGMed = 0.1740
    let USGThird = 0.2110
    let USGMax = 0.2890
    
    
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
        let partThree = Double((astScore + tovScore)/2) * 0.15
        let partFour = Double(trbScore) * 0.15
        statsScore = (partOne + partTwo + partThree + partFour)/3
        print ("Total score: \(statsScore)")
        
        
    }
}