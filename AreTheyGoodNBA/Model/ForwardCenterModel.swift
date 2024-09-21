//
//  ForwardCenterModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class ForwardCenterModel: PlayerModel {
    
    let TSMin = 0.412
    let TSFirst = 0.5965
    let TSMed = 0.625
    let TSThird = 0.6478
    let TSMax = 0.736
    
    //Assist per min
    
    let ASTMin = 0.02419
    let ASTFirst = 0.05397
    let ASTMed = 0.06913
    let ASTThird = 0.09796
    let ASTMax = 0.22969
    
    //Total Rebounds per min
    
    let TRBMin = 0.1481
    let TRBFirst = 0.2429
    let TRBMed = 0.2662
    let TRBThird = 0.3229
    let TRBMax = 0.3838
    
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
    
    let TOVMin = 0.4938
    let TOVFirst = 0.3828
    let TOVMed = 0.3002
    let TOVThird = 0.255
    let TOVMax = 0.1755
    
    
    let ORTGMin = 100.9
    let ORTGFirst = 109.4
    let ORTGMed = 113.6
    let ORTGThird = 116.3
    let ORTGMax = 121.8
    
    //reverse DRTG
    
    let DRTGMin = 119.1
    let DRTGFirst = 114.4
    let DRTGMed = 112.8
    let DRTGThird = 109.6
    let DRTGMax = 103.5
    
    let USGMin = 0.0870
    let USGFirst = 0.1290
    let USGMed = 0.169
    let USGThird = 0.2233
    let USGMax = 0.3870
    
    let PTMin = 0.2258
    let PTFirst = 0.3237
    let PTMed = 0.4326
    let PTThird = 0.5603
    let PTMax = 1.0327
    
    
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
        
            let optionalModel: PlayerModel = ForwardModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            let thirdModel: PlayerModel = CenterModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            scoreAdjustment(optionalModel: optionalModel, thirdModel: thirdModel)
            
        }
        
        calculateResult()
        
    }

}
