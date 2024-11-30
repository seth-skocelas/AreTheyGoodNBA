//
//  ForwardCenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class WNBAForwardCenterModel: PlayerModel {
    
    let TSMin = 0.487
    let TSFirst = 0.5012
    let TSMed = 0.536
    let TSThird = 0.5690
    let TSMax = 0.578
    
    //Assist per min
    
    let ASTMin = 0.04545
    let ASTFirst = 0.06022
    let ASTMed = 0.07103
    let ASTThird = 0.08358
    let ASTMax = 0.10356
    
    //Total Rebounds per min
    
    let TRBMin = 0.2606
    let TRBFirst = 0.2777
    let TRBMed = 0.2857
    let TRBThird = 0.3019
    let TRBMax = 0.3434
    
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
    
    let TOVMin = 0.3987
    let TOVFirst = 0.3771
    let TOVMed = 0.3476
    let TOVThird = 0.3152
    let TOVMax = 0.285
    
    
    let ORTGMin = 91.6
    let ORTGFirst = 93.88
    let ORTGMed = 98.9
    let ORTGThird = 102.97
    let ORTGMax = 104.7
    
    //reverse DRTG
    
    let DRTGMin = 107.3
    let DRTGFirst = 106.62
    let DRTGMed = 100.6
    let DRTGThird = 93.88
    let DRTGMax = 91.1
    
    let USGMin = 0.16
    let USGFirst = 0.1878
    let USGMed = 0.198
    let USGThird = 0.2253
    let USGMax = 0.304
    
    let PTMin = 0.3811
    let PTFirst = 0.3868
    let PTMed = 0.4209
    let PTThird = 0.4888
    let PTMax = 0.569
    
    
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
        let partThree = Double((astScore + tovScore)/2) * 0.075
        let partFour = Double(trbScore) * 0.175
        let partFive = Double(ptScore) * 0.2
        
        statsScore = (partOne + partTwo + partThree + partFour + partFive)/3
        print ("Total score: \(statsScore)")
        
        if statsScore < goodCutoff && !isSecondary {
        
            let optionalModel: PlayerModel = WNBAForwardModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            let thirdModel: PlayerModel = WNBACenterModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            scoreAdjustment(optionalModel: optionalModel, thirdModel: thirdModel)
            
        }
        
        calculateResult()
        
    }

}
