//
//  WNBAGuardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 9/29/24.
//  Copyright © 2024 Seth Skocelas. All rights reserved.
//

import Foundation

class WNBAGuardModel: PlayerModel {
    
    let TSMin = 0.383
    let TSFirst = 0.4855
    let TSMed = 0.513
    let TSThird = 0.545
    let TSMax = 0.6180
    
    //Assist per min
    
    let ASTMin = 0.04908
    let ASTFirst = 0.08661
    let ASTMed = 0.11923
    let ASTThird = 0.16144
    let ASTMax = 0.23729
    
    //Total Rebounds per min
    
    let TRBMin = 0.05759
    let TRBFirst = 0.08141
    let TRBMed = 0.10563
    let TRBThird = 0.13032
    let TRBMax = 0.18436

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
    
    let TOVMin = 0.6887
    let TOVFirst = 0.4274
    let TOVMed = 0.3547
    let TOVThird = 0.2932
    let TOVMax = 0.1895
    
    let ORTGMin = 88.4
    let ORTGFirst = 97.25
    let ORTGMed = 100.4
    let ORTGThird = 102.7
    let ORTGMax = 109.2
    
    //reverse DRTG
    
    let DRTGMin = 112.2
    let DRTGFirst = 103.9
    let DRTGMed = 100.4
    let DRTGThird = 97.3
    let DRTGMax = 89.7
    
    let USGMin = 0.118
    let USGFirst = 0.1505
    let USGMed = 0.186
    let USGThird = 0.228
    let USGMax = 0.284
    
    let PTMin = 0.1745
    let PTFirst = 0.3019
    let PTMed = 0.3453
    let PTThird = 0.4755
    let PTMax = 0.6731
    
    
    
    override init(player: Player, statDuration: StatDuration, isSecondary: Bool) {
        
        super.init(player: player, statDuration: statDuration, isSecondary: isSecondary)
        
        calculateScore()
        
    }
    
    func calculateScore() {
        
        //update to match center model
        
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
        let partThree = Double((astScore + tovScore)/2) * 0.2
        let partFour = Double(trbScore) * 0.05
        let partFive = Double(ptScore) * 0.2
        statsScore = (partOne + partTwo + partThree + partFour + partFive)/3
        print ("Total score: \(statsScore)")
        calculateResult()

        
    }
    


    
    
    
    

}
