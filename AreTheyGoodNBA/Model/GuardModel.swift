//
//  GuardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class GuardModel: PlayerModel {
    
    let TSMin = 0.4350
    let TSFirst = 0.5353
    let TSMed = 0.5685
    let TSThird = 0.5942
    let TSMax = 0.679
    
    //Assist per min
    
    let ASTMin = 0.04
    let ASTFirst = 0.09474
    let ASTMed = 0.14752
    let ASTThird = 0.18957
    let ASTMax = 0.30220
    
    //Total Rebounds per min
    
    let TRBMin = 0.05755
    let TRBFirst = 0.10007
    let TRBMed = 0.11785
    let TRBThird = 0.13666
    let TRBMax = 0.24850

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
    
    let TOVMin = 0.53742
    let TOVFirst = 0.32157
    let TOVMed = 0.26617
    let TOVThird = 0.22329
    let TOVMax = 0.09198
    
    let ORTGMin = 101.7
    let ORTGFirst = 110.6
    let ORTGMed = 113.9
    let ORTGThird = 117.0
    let ORTGMax = 122.4
    
    //reverse DRTG
    
    let DRTGMin = 122.5
    let DRTGFirst = 115.2
    let DRTGMed = 112.5
    let DRTGThird = 110.6
    let DRTGMax = 100.1
    
    let USGMin = 0.096
    let USGFirst = 0.1502
    let USGMed = 0.1825
    let USGThird = 0.2352
    let USGMax = 0.311
    
    let PTMin = 0.186
    let PTFirst = 0.3512
    let PTMed = 0.4498
    let PTThird = 0.5592
    let PTMax = 0.8107
    
    
    
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
