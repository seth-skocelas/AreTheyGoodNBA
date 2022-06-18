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
    
    let TSMin = 0.4380
    let TSFirst = 0.5470
    let TSMed = 0.5770
    let TSThird = 0.599
    let TSMax = 0.689
    
    //Assist per min
    
    let ASTMin = 0.02222
    let ASTFirst = 0.04803
    let ASTMed = 0.05929
    let ASTThird = 0.07651
    let ASTMax = 0.24221
    
    //Total Rebounds per min
    
    let TRBMin = 0.09583
    let TRBFirst = 0.15209
    let TRBMed = 0.18861
    let TRBThird = 0.24176
    let TRBMax = 0.35258
    
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
    
    let TOVMin = 0.74147
    let TOVFirst = 0.29680
    let TOVMed = 0.24874
    let TOVThird = 0.21011
    let TOVMax = 0.09142
    
    
    let ORTGMin = 95.5
    let ORTGFirst = 107.2
    let ORTGMed = 110.4
    let ORTGThird = 113.3
    let ORTGMax = 118.1
    
    //reverse DRTG
    
    let DRTGMin = 121.5
    let DRTGFirst = 112.6
    let DRTGMed = 110.4
    let DRTGThird = 107.9
    let DRTGMax = 102.8
    
    let USGMin = 0.098
    let USGFirst = 0.1440
    let USGMed = 0.172
    let USGThird = 0.2050
    let USGMax = 0.34
    
    let PTMin = 0.2073
    let PTFirst = 0.3220
    let PTMed = 0.4172
    let PTThird = 0.5022
    let PTMax = 0.9088
    
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
