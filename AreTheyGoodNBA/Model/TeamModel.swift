//
//  TeamModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/19/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class TeamModel {
    
    let goodCutoff = 0.5
    
    var statsScore = 0.0
    var result = Result.Inconclusive
    var scoreDict = Dictionary<String, Int>()
    
    var testStatDuration: StatDuration = StatDuration.CurrentSeason
    var testTeam: Team
    
    var teamRegularTradStats: TradStats!
    var teamRegularAdvStats: AdvStats!
    
    //--------
    
    let NETMin = -9.3
    let NETFirst = -3.4
    let NETMedian = 0.5
    let NETThird = 2.9
    let NETMax = 8.6
    
    let WINMin = 0.2561
    let WINFirst = 0.3445
    let WINMedian = 0.5366
    let WINThird = 0.5854
    let WINMax = 0.7927
    
    
    init(team: Team, statDuration: StatDuration) {
        
        self.testTeam = team
        self.testStatDuration = statDuration
        
        if statDuration == StatDuration.CurrentSeason {
            
            teamRegularTradStats = self.testTeam.currentRegularSeasonTradStats
            teamRegularAdvStats = self.testTeam.currentRegularSeasonAdvStats
            
        } else if statDuration == StatDuration.Career {
            
            
        }
        
        calculateScore()
        
    }
    
    func calculateHighStatScore(stat: Double, first: Double, median: Double, third: Double) -> Int {
        
        var score = 0
        
        if stat >= third {
            score = 3
        } else if stat >= median {
            score = 2
        } else if stat >= first {
            score = 1
        }
        
        return score
    }
    
    func calculateScore() {
        
        
        let winScore = calculateHighStatScore(stat: testTeam.currentWinPer, first: WINFirst, median: WINMedian, third: WINThird)
        print("Team Stat: \(testTeam.currentWinPer) - Team Score: \(winScore)")
        scoreDict.updateValue(winScore, forKey: "win percentage")
        
        let netScore = calculateHighStatScore(stat: teamRegularAdvStats.netRating, first: NETFirst, median: NETMedian, third: NETThird)
        print("Team Stat: \(teamRegularAdvStats.netRating) - Team Score: \(netScore)")
        scoreDict.updateValue(netScore, forKey: "net rating")
        
        
        let partOne = Double(winScore) * 0.5
        let partTwo = Double(netScore) * 0.5
        
        statsScore = (partOne + partTwo)/3
        print ("Total score: \(statsScore)")
        calculateResult()
        
        
    }
    
    func calculateResult() {
            
        if statsScore >= goodCutoff {
            result = Result.Yes
        } else {
            result = Result.No
        }
        
    }
 
    
    
}
