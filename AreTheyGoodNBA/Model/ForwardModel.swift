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
    
    let TSMin = 0.382
    let TSFirst = 0.5375
    let TSMed = 0.57
    let TSThird = 0.598
    let TSMax = 0.692
    
    //Assist per min
    
    let ASTMin = 0.03165
    let ASTFirst = 0.0526
    let ASTMed = 0.07071
    let ASTThird = 0.09759
    let ASTMax = 0.23513
    
    //Total Rebounds per min
    
    let TRBMin = 0.06383
    let TRBFirst = 0.15123
    let TRBMed = 0.17742
    let TRBThird = 0.21644
    let TRBMax = 0.35404
    
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
    
    let TOVMin = 0.6233
    let TOVFirst = 0.3061
    let TOVMed = 0.2623
    let TOVThird = 0.2182
    let TOVMax = 0.111
    
    
    let ORTGMin = 98.3
    let ORTGFirst = 107.3
    let ORTGMed = 111.4
    let ORTGThird = 114.6
    let ORTGMax = 121.3
    
    //reverse DRTG
    
    let DRTGMin = 125.4
    let DRTGFirst = 115.5
    let DRTGMed = 113.0
    let DRTGThird = 110.8
    let DRTGMax = 102.1
    
    let USGMin = 0.093
    let USGFirst = 0.141
    let USGMed = 0.163
    let USGThird = 0.1985
    let USGMax = 0.32
    
    let PTMin = 0.1607
    let PTFirst = 0.3261
    let PTMed = 0.3949
    let PTThird = 0.4891
    let PTMax = 0.8636
    
    var optionalModel: PlayerModel!
    
    
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
        let partThree = Double((astScore + tovScore)/2) * 0.125
        let partFour = Double(trbScore) * 0.125
        let partFive = Double(ptScore) * 0.2
        
        statsScore = (partOne + partTwo + partThree + partFour + partFive)/3
        
        print ("Total score: \(statsScore)")
        
        if statsScore <= goodCutoff && !isSecondary {
            
            optionalModel = ForwardCenterModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            scoreAdjustment(optionalModel: optionalModel)
           
        }
        
        calculateResult()
        
        
    }
}
