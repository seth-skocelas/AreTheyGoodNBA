//
//  TeamModelResponse.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/21/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class TeamModelResponse {
    
    var teamModel: TeamModel!
    var team: Team!
    var advStats: AdvStats!
    var rankDict: Dictionary<Int, String>!
    var maxStatScore: Int!
    var maxStatString: String = ""
    var minStatScore: Int!
    var minStatString: String = ""
    
    let rankKeys = [3,2,1,0]
    let rankValues = ["among the best", "in the top 50%", "in the bottom 50%", "among the worst"]
    
    init(model: TeamModel) {
        
        teamModel = model
        rankDict = Dictionary(uniqueKeysWithValues: zip(rankKeys, rankValues))
        setTeamInfo()
    }
    
    func setTeamInfo() {
        
        team = teamModel.testTeam
        
        if teamModel.testStatDuration == StatDuration.CurrentSeason {
            advStats = team.currentRegularSeasonAdvStats
        } else {
            getMinMaxStats()
        }
        
    }
    
    func goodOrNotGood() -> String {
        
        if teamModel.result == Result.Yes {
            return "good"
        } else {
            return "not good"
        }
        
    }
    
    func firstLine() -> String {
        
        let startingString = "The \(team.teamName) are \(goodOrNotGood()) "
        
        if teamModel.testStatDuration == StatDuration.CurrentSeason {
            return startingString + "this regular season based on their record and net rating so far."
        } else {
            return startingString + "based on their performance over the history of their franchise."
        }
        
    }
    
    func secondLine() -> String {
        
        if teamModel.testStatDuration == StatDuration.CurrentSeason {
            if let rankString = rankDict[teamModel.winScore] {
                return "Their win percentage is \(rankString) of all 30 teams."
            }
        } else {

        }
        
        return ""
        
    }
    
    func thirdLine() -> String {
        
        if teamModel.testStatDuration == StatDuration.CurrentSeason {
            if let rankString = rankDict[teamModel.netScore] {
                return "Their net ranking is \(rankString) of all 30 teams."
            }
        } else {
            
        }
        
        return ""
        
    }
    
    func getMinMaxStats() {
        
        if let maxStat = teamModel.scoreDict.max(by: { a, b in a.value < b.value }) {
            
            maxStatScore = maxStat.value
            maxStatString = maxStat.key
            
        } else {
            
            print("Max Stat unavailable")
            
        }
        
        if let minStat = teamModel.scoreDict.min(by: { a, b in a.value < b.value }) {
            
            minStatScore = minStat.value
            minStatString = minStat.key
            
        } else {
            
            print("Min Stat unavailable")
            
        }
        
    }
    
    
}
