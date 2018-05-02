//
//  GuardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.4210
    let TSFirst = 0.5030
    let TSMed = 0.5356
    let TSThird = 0.5633
    let TSMax = 0.6750
    
    //Assist per min
    
    let ASTMin = 0.02959
    let ASTFirst = 0.08371
    let ASTMed = 0.12597
    let ASTThird = 0.17657
    let ASTMax = 0.31261
    
    //Total Rebounds per min
    
    let TRBMin = 0.05989
    let TRBFirst = 0.09875
    let TRBMed = 0.11551
    let TRBThird = 0.13272
    let TRBMax = 0.27591

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
    
    let TOVMin = 0.5240
    let TOVFirst = 0.3500
    let TOVMed = 0.2937
    let TOVThird = 0.2448
    let TOVMax = 0.1081
    
    
    let ORTGMin = 89.0
    let ORTGFirst = 101.0
    let ORTGMed = 106.0
    let ORTGThird = 111.0
    let ORTGMax = 126.0
    
    //reverse DRTG
    
    let DRTGMin = 117.0
    let DRTGFirst = 112.0
    let DRTGMed = 110.0
    let DRTGThird = 109.0
    let DRTGMax = 101.0
    
    let USGMin = 0.1130
    let USGFirst = 0.1218
    let USGMed = 0.1960
    let USGThird = 0.2455
    let USGMax = 0.3610
    
    
    override init(player: Player, statDuration: StatDuration) {
        
        super.init(player: player, statDuration: statDuration)
        
        calculateScore()
        
    }
    
    func calculateScore() {
        
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
        
        let tovScore = calculateLowStatScore(stat: tovMin, first: TOVFirst, median: TOVMed, third: TOVThird)
        print("Player Stat: \(tovMin) - Player Score: \(tovScore)")
        
        let partOne = Double(tsScore) * 0.4
        let partTwo = Double((ortgScore + drtgScore)/2) * 0.3
        let partThree = Double((astScore + trbScore + tovScore)/3) * 0.3
        statsScore = (partOne + partTwo + partThree)/3
        print ("Total score: \(statsScore)")

        
    }
    


    
    
    
    

}
