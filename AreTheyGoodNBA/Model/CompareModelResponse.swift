//
//  CompareModelResponse.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 12/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class CompareModelResponse {
    
    var onePlayerModel: PlayerModel!
    var onePlayer: Player!
    var oneTradStats: TradStats!
    var oneAdvStats: AdvStats!
    var onePositionString = ""
    
    var twoPlayerModel: PlayerModel!
    var twoPlayer: Player!
    var twoTradStats: TradStats!
    var twoAdvStats: AdvStats!
    var twoPositionString = ""
    
    init(oneModel: PlayerModel, twoModel: PlayerModel) {
        
        onePlayerModel = oneModel
        twoPlayerModel = twoModel
        setPlayerInfo()
    }
    
    func setPlayerInfo() {
        
        onePlayer = onePlayerModel.testPlayer
        twoPlayer = twoPlayerModel.testPlayer
        
        if onePlayerModel.testStatDuration == StatDuration.CurrentSeason {
            oneAdvStats = onePlayer.currentRegularSeasonAdvStats
            oneTradStats = onePlayer.currentRegularSeasonTradStats
        } else {
            oneAdvStats = onePlayer.careerRegularSeasonAdvStats
            oneTradStats = onePlayer.careerRegularSeasonTradStats
        }
        
        if twoPlayerModel.testStatDuration == StatDuration.CurrentSeason {
            twoAdvStats = twoPlayer.currentRegularSeasonAdvStats
            twoTradStats = twoPlayer.currentRegularSeasonTradStats
        } else {
            twoAdvStats = twoPlayer.careerRegularSeasonAdvStats
            twoTradStats = twoPlayer.careerRegularSeasonTradStats
        }
        
    }
    
    func goodOrNotGood(model: PlayerModel) -> String {
        
        if model.finalResult == Result.Yes || model.inconclusiveResult == Result.Yes {
            return "good"
        } else {
            return "not good"
        }
        
    }
    
    func firstLine() -> String {
        
        if onePlayerModel.inconclusiveData() || twoPlayerModel.inconclusiveData() {
            return "One or both players have not played enough to produce an accurate model score, so please compare stats to make a better judgement."
        } else if onePlayerModel.statsScore > twoPlayerModel.statsScore {
            return "\(onePlayer.lastName) has a higher model score than \(twoPlayer.lastName)."
        } else if onePlayerModel.statsScore < twoPlayerModel.statsScore {
            return "\(twoPlayer.lastName) has a higher model score than \(onePlayer.lastName)."
        } else {
            return "Both players have the same model score for their position."
        }
        
    }
    
    /*
    
    func secondLine() -> String {
        
        if playerModel.inconclusiveData() {
            
            if !(tradStats.isEmpty) || !(advStats.isEmpty) {
                return "The model would have determined he was \(goodOrNotGood()) based on his production."
            }
            
            return ""
            
        } else if minStatScore != rankKeys[0] {
            
            if let rankString = rankDict[maxStatScore] {
                return "His strength is his \(maxStatString), which is \(rankString) of \(positionString)."
            }
            
        } else {
            return "All of his stats graded by the model are among the best of \(positionString), meaning they are all in the top 25%."
        }
        
        return ""
        
    }
    
    func thirdLine() -> String {
        
        if minStatScore != rankKeys[0] && !playerModel.inconclusiveData() {
            
            if let rankString = rankDict[minStatScore] {
                return "His weakness is his \(minStatString), which is \(rankString) of \(positionString)."
            }
            
        }
        
        return " "
        
    }
    
    */
    
}
