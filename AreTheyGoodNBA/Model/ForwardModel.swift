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
    
    let TSMin = 0.3950
    let TSFirst = 0.5305
    let TSMed = 0.5700
    let TSThird = 0.5940
    let TSMax = 0.6850
    
    //Assist per min
    
    let ASTMin = 0.02290
    let ASTFirst = 0.04676
    let ASTMed = 0.05802
    let ASTThird = 0.07632
    let ASTMax = 0.30372
    
    //Total Rebounds per min
    
    let TRBMin = 0.1100
    let TRBFirst = 0.1628
    let TRBMed = 0.1946
    let TRBThird = 0.2340
    let TRBMax = 0.4434
    
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
    
    let TOVMin = 0.67086
    let TOVFirst = 0.32268
    let TOVMed = 0.27903
    let TOVThird = 0.22351
    let TOVMax = 0.08024
    
    
    let ORTGMin = 92.6
    let ORTGFirst = 104.2
    let ORTGMed = 108.6
    let ORTGThird = 110.8
    let ORTGMax = 116.8
    
    //reverse DRTG
    
    let DRTGMin = 117.8
    let DRTGFirst = 111.1
    let DRTGMed = 108.5
    let DRTGThird = 104.5
    let DRTGMax = 96.5
    
    let USGMin = 0.0800
    let USGFirst = 0.1445
    let USGMed = 0.1650
    let USGThird = 0.2040
    let USGMax = 0.3620
    
    let PTMin = 0.1923
    let PTFirst = 0.3307
    let PTMed = 0.4026
    let PTThird = 0.5057
    let PTMax = 0.9579
    
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
