//
//  ModelResponse.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/16/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class PlayerModelResponse {
    
    var playerModel: PlayerModel!
    var player: Player!
    var tradStats: TradStats!
    var advStats: AdvStats!
    var positionString = ""
    var positionDict: Dictionary<Position, String>!
    var rankDict: Dictionary<Int, String>!
    var maxStatScore: Int!
    var maxStatString: String = ""
    var minStatScore: Int!
    var minStatString: String = ""
    var lowerPronoun = "they"
    var capPronoun = "They"
    var lowerPoss = "their"
    var capPoss = "their"
    
    
    let hsgCutoff = 0.25
    let starterCutoff = 24.0
    let roleCutoff = 18.0
    
    let positionKeys = [Position.Guard, Position.GuardForward, Position.Forward, Position.ForwardCenter, Position.Center]
    let positionValues = ["guards", "swingmen", "forwards", "stretch fives", "centers"]
    let rankKeys = [3,2,1,0]
    let rankValues = ["among the best", "in the top 50%", "in the bottom 50%", "among the worst"]
    
    //Static First Line Strings
    
    var husFirst = "based on his production as a high-usage starter."
    var starterFirst = "based on his production as a starter."
    var roleFirst = "based on his production as a role player."
    var fringeFirst = "based on his production as a fringe player."
    var unknownFirst = "did not play enough to be judged by the model."
    
    init(model: PlayerModel) {
        
        playerModel = model
        positionDict = Dictionary(uniqueKeysWithValues: zip(positionKeys, positionValues))
        rankDict = Dictionary(uniqueKeysWithValues: zip(rankKeys, rankValues))
        setPlayerInfo()
    }
    
    func setPlayerInfo() {
        
        player = playerModel.testPlayer
        setPronoun()
        positionString = positionDict[playerModel.testPlayer.modelPosition]!
        
        if playerModel.testStatDuration == StatDuration.CurrentSeason {
            advStats = player.currentRegularSeasonAdvStats
            tradStats = player.currentRegularSeasonTradStats
        } else {
            advStats = player.careerRegularSeasonAdvStats
            tradStats = player.careerRegularSeasonTradStats
        }
        
        getMinMaxStats()
        
    }
    
    func goodOrNotGood() -> String {
        
        if playerModel.finalResult == Result.Yes || playerModel.inconclusiveResult == Result.Yes {
            return "good"
        } else {
            return "not good"
        }
        
    }
    
    func firstLine() -> String {
        
        let startingString = "\(player.name) is \(goodOrNotGood()) "
        
        if let response = specialResponseDict[player.playerID], playerModel.testStatDuration == StatDuration.CurrentSeason {
    
            return response
            
        } else if playerModel.inconclusiveData() == false {
        
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
        
        if playerModel.inconclusiveData() {
            
            if !(tradStats.isEmpty) || !(advStats.isEmpty) {
                return "The model would have determined \(lowerPronoun) was \(goodOrNotGood()) based on \(lowerPoss) production."
            }
            
            return ""
            
        } else if minStatScore != rankKeys[0] {
            
            if let rankString = rankDict[maxStatScore] {
                return "\(capPoss) strength is \(lowerPoss) \(maxStatString), which is \(rankString) of \(positionString)."
            }
            
        } else {
            return "All of \(lowerPoss) stats graded by the model are among the best of \(positionString), meaning they are all in the top 25%."
        }
        
        return ""
        
    }
    
    func thirdLine() -> String {
        
        if minStatScore != rankKeys[0] && !playerModel.inconclusiveData() {
        
            if let rankString = rankDict[minStatScore] {
                return "\(capPoss) weakness is \(lowerPoss) \(minStatString), which is \(rankString) of \(positionString)."
            }
            
        }

        return " "
        
    }
    
    func getMinMaxStats() {
        
        if let maxStat = playerModel.scoreDict.max(by: { a, b in a.value < b.value }) {
            
            maxStatScore = maxStat.value
            maxStatString = maxStat.key
            
        } else {
            
            print("Max Stat unavailable")
            
        }
        
        if let minStat = playerModel.scoreDict.min(by: { a, b in a.value < b.value }) {
            
            minStatScore = minStat.value
            minStatString = minStat.key
            
        } else {
            
            print("Min Stat unavailable")
            
        }
        
    }
    
    func setPronoun() {
        
        if player.leagueName == LeagueName.WNBA {
            lowerPronoun = "she"
            capPronoun = "She"
            lowerPoss = "her"
            capPoss = "Her"
        }
        else if player.leagueName == LeagueName.NBA {
            lowerPronoun = "he"
            capPronoun = "He"
            lowerPoss = "his"
            capPoss = "His"
        }
        
        husFirst = "based on \(lowerPoss) production as a high-usage starter."
        starterFirst = "based on \(lowerPoss) production as a starter."
        roleFirst = "based on \(lowerPoss) production as a role player."
        fringeFirst = "based on \(lowerPoss) production as a fringe player."
        
    }
    
    
    
    
}
