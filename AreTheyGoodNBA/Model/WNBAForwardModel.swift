//
//  WNBAForwardModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 9/29/24.
//  Copyright © 2024 Seth Skocelas. All rights reserved.
//


import Foundation

class WNBAForwardModel: PlayerModel {
    
    //slight minutes discrepancy between data from nba.com and Basketball Reference
    
    let TSMin = 0.383
    let TSFirst = 0.5125
    let TSMed = 0.545
    let TSThird = 0.571
    let TSMax = 0.624
    
    //Assist per min
    
    let ASTMin = 0.02778
    let ASTFirst = 0.05780
    let ASTMed = 0.07407
    let ASTThird = 0.10072
    let ASTMax = 0.24383
    
    //Total Rebounds per min
    
    let TRBMin = 0.09626
    let TRBFirst = 0.14584
    let TRBMed = 0.21176
    let TRBThird = 0.25286
    let TRBMax = 0.40308
    
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
    
    let TOVMin = 0.6105
    let TOVFirst = 0.4256
    let TOVMed = 0.3388
    let TOVThird = 0.2735
    let TOVMax = 0.1596
    
    
    let ORTGMin = 81.7
    let ORTGFirst = 95.8
    let ORTGMed = 99.7
    let ORTGThird = 104.0
    let ORTGMax = 109.2
    
    //reverse DRTG
    
    let DRTGMin = 114.5
    let DRTGFirst = 104.95
    let DRTGMed = 99.3
    let DRTGThird = 95.15
    let DRTGMax = 190.7
    
    let USGMin = 0.1080
    let USGFirst = 0.145
    let USGMed = 0.182
    let USGThird = 0.2145
    let USGMax = 0.271
    
    let PTMin = 0.216
    let PTFirst = 0.3015
    let PTMed = 0.3529
    let PTThird = 0.4472
    let PTMax = 0.6239
    
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
            
            optionalModel = WNBAForwardCenterModel(player: testPlayer, statDuration: testStatDuration, isSecondary: true)
            scoreAdjustment(optionalModel: optionalModel)
           
        }
        
        calculateResult()
        
        
    }
}
