//
//  ModelResponse.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/16/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class ModelResponse {
    
    var playerModel: PlayerModel!
    var player: Player!
    var tradStats: TradStats!
    var advStats: AdvStats!
    
    
    let hsgCutoff = 0.25
    let starterCutoff = 24.0
    let roleCutoff = 18.0
    
    //Static First Line Strings
    
    let husFirst = "based on his production as a high-usage starter."
    let starterFirst = "based on his production as a starter."
    let roleFirst = "based on his production as a role player."
    let fringeFirst = "based on his production as a fringe player."
    let unknownFirst = "did not play enough to be judged by the model."
    
    init(model: PlayerModel) {
        playerModel = model
        setPlayerInfo()
    }
    
    func setPlayerInfo() {
        
        player = playerModel.testPlayer
        
        if playerModel.testStatDuration == StatDuration.CurrentSeason {
            advStats = player.currentRegularSeasonAdvStats
            tradStats = player.currentRegularSeasonTradStats
        } else {
            advStats = player.careerRegularSeasonAdvStats
            tradStats = player.careerRegularSeasonTradStats
        }
        
    }
    
    func goodOrNotGood() -> String {
        
        if playerModel.result == Result.Yes {
            return "good"
        } else {
            return "not good"
        }
        
    }
    
    func firstLine() -> String {
        
        let startingString = "\(player.name) is \(goodOrNotGood()) "
        
        if playerModel.inconclusiveData() == false {
        
            if advStats.usage >= 0.25 && tradStats.minutesPlayed >= 24.0 {
                return startingString + husFirst
            } else if tradStats.minutesPlayed >= 24.0 {
                return startingString + starterFirst
            } else if tradStats.minutesPlayed >= 18.0 {
                return startingString + roleFirst
            } else {
                return startingString + fringeFirst
            }
        
        } else {
            
            return "\(player.name) " + unknownFirst
            
        }
    
    }
    
    func secondLine() -> String {
        
        if let maxStat = playerModel.scoreDict.max(by: { a, b in a.value < b.value }) {
            return "His strength is his \(maxStat.key), which is in the top half of players in his position."
        }
        
        return ""
        
    }
    
    func thirdLine() -> String {
        
        if let minStat = playerModel.scoreDict.min(by: { a, b in a.value < b.value }) {
            return "His weakness is his \(minStat.key), which is in the bottom half of players in his position."
        }
        
        return ""
        
    }
    
}
