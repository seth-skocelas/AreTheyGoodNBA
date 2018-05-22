//
//  TeamModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/19/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class TeamModel {
    
    let goodCutoff = 0.4995 //fix this
    
    var statsScore = 0.0
    var result = Result.Inconclusive
    var scoreDict = Dictionary<String, Int>()
    
    var testStatDuration: StatDuration = StatDuration.CurrentSeason
    var testTeam: Team
    
    var teamRegularTradStats: TradStats!
    var teamRegularAdvStats: AdvStats!
    
    var winScore = 0
    var netScore = 0
    
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
    
    //-----------
    
    let perMin = 0.3970
    let perFirst = 0.4617
    let perMedian = 0.4975
    let perThird = 0.5238
    let perMax = 0.6020
    
    let playMin = 0.2708
    let playFirst = 0.4427
    let playMedian = 0.5610
    let playThird = 0.6569
    let playMax = 0.8571
    
    let confMin = 0.0000
    let confFirst = 0.01960
    let confMedian = 0.05409
    let confThird = 0.07694
    let confMax = 0.25714
    
    let champMin = 0.0
    let champFirst = 0.01428
    let champMedian = 0.01858
    let champThird = 0.04195
    let champMax = 0.23611
    
    
    
    
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
        
        if testStatDuration == StatDuration.CurrentSeason {
        
            winScore = calculateHighStatScore(stat: testTeam.currentWinPer, first: WINFirst, median: WINMedian, third: WINThird)
            print("Team Stat: \(testTeam.currentWinPer) - Team Score: \(winScore)")
            scoreDict.updateValue(winScore, forKey: "win percentage")
        
            netScore = calculateHighStatScore(stat: teamRegularAdvStats.netRating, first: NETFirst, median: NETMedian, third: NETThird)
            print("Team Stat: \(teamRegularAdvStats.netRating) - Team Score: \(netScore)")
            scoreDict.updateValue(netScore, forKey: "net rating")
        
        
            let partOne = Double(winScore) * 0.5
            let partTwo = Double(netScore) * 0.5
        
            statsScore = (partOne + partTwo)/3
            
        } else { //Franchise History
            
            var tempStat = 0.0
            
            let perScore = calculateHighStatScore(stat: testTeam.winPercentage, first: perFirst, median: perMedian, third: perThird)
            print("Team Stat - WinPER: \(testTeam.winPercentage) - Team Score: \(perScore)")
            scoreDict.updateValue(perScore, forKey: "win percentage")
            
            tempStat = Double(testTeam.leagueTitles)/Double(testTeam.years)
            let champScore = calculateHighStatScore(stat: tempStat, first: champFirst, median: champMedian, third: champThird)
            print("Team Stat - Champ: \(tempStat) - Team Score: \(champScore)")
            scoreDict.updateValue(champScore, forKey: "number of league titles")
            
            tempStat = Double(testTeam.conferenceTitles)/Double(testTeam.years)
            let confScore = calculateHighStatScore(stat: tempStat, first: confFirst, median: confMedian, third: confThird)
            print("Team Stat - CONF: \(tempStat) - Team Score: \(confScore)")
            scoreDict.updateValue(confScore, forKey: "number of conference titles")
            
            tempStat = Double(testTeam.playoffApperances)/Double(testTeam.years)
            let playScore = calculateHighStatScore(stat: tempStat, first: playFirst, median: playMedian, third: playThird)
            print("Team Stat - PLAYOFFS: \(tempStat) - Team Score: \(playScore)")
            scoreDict.updateValue(playScore, forKey: "number of playoff apperances")
            
            let partOne = Double(champScore) * 0.4
            let partTwo = Double(playScore) * 0.3
            let partThree = Double(perScore) * 0.2
            let partFour = Double(confScore) * 0.1
            
            statsScore = (partOne + partTwo + partThree + partFour)/3
            
        }
        
        
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
