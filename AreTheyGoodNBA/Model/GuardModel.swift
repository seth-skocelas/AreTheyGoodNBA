//
//  GuardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardModel: PlayerModel {
    
    let TSMin = 0.397
    let TSFirst = 0.526
    let TSMed = 0.548
    let TSThird = 0.576
    let TSMax = 0.62
    
    //Assist per min
    
    let ASTMin = 0.03226
    let ASTFirst = 0.0838
    let ASTMed = 0.13333
    let ASTThird = 0.17678
    let ASTMax = 0.32827
    
    //Total Rebounds per min
    
    let TRBMin = 0.06552
    let TRBFirst = 0.10909
    let TRBMed = 0.12245
    let TRBThird = 0.13939
    let TRBMax = 0.25698

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
    
    let TOVMin = 0.6255
    let TOVFirst = 0.3623
    let TOVMed = 0.2793
    let TOVThird = 0.228
    let TOVMax = 0.1058
    
    let ORTGMin = 93.8
    let ORTGFirst = 106.8
    let ORTGMed = 110.5
    let ORTGThird = 112.7
    let ORTGMax = 118.9
    
    //reverse DRTG
    
    let DRTGMin = 118.7
    let DRTGFirst = 111.7
    let DRTGMed = 110.1
    let DRTGThird = 107.7
    let DRTGMax = 99.5
    
    let USGMin = 0.097
    let USGFirst = 0.16
    let USGMed = 0.195
    let USGThird = 0.237
    let USGMax = 0.333
    
    let PTMin = 0.1835
    let PTFirst = 0.3564
    let PTMed = 0.4488
    let PTThird = 0.54
    let PTMax = 0.8278
    
    
    
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
