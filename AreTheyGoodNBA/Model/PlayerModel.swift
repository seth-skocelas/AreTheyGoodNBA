//
//  Model.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class PlayerModel {
    
    var statsScore = 0.0

    var testStatDuration: StatDuration = StatDuration.CurrentSeason
    
    var testPlayer: Player
    
    var playerRegularTradStats: TradStats!
    var playerRegularAdvStats: AdvStats!
    
    init(player: Player, statDuration: StatDuration) {
        
        self.testPlayer = player
        self.testStatDuration = statDuration
        
        if statDuration == StatDuration.CurrentSeason {
            
            playerRegularTradStats = self.testPlayer.currentRegularSeasonTradStats
            playerRegularAdvStats = self.testPlayer.currentRegularSeasonAdvStats
            
        } else if statDuration == StatDuration.Career {
            
            playerRegularTradStats = self.testPlayer.careerRegularSeasonTradStats
            playerRegularAdvStats = self.testPlayer.careerRegularSeasonAdvStats
            
        }
        
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
    
    func calculateLowStatScore(stat: Double, first: Double, median: Double, third: Double) -> Int {
        
        var score = 0
        
        if stat <= third {
            score = 3
        } else if stat <= median {
            score = 2
        } else if stat <= first {
            score = 1
        }
        
        return score
    }
    
    func careerLegendCheck() {
        
        if testPlayer.yearsExperience >= 12 && testPlayer.careerRegularSeasonAdvStats.usage >= 0.23 {
            self.statsScore += 1
            print("Score boosted to \(self.statsScore) for being a high usage player for over 10 years")
        } else if testPlayer.yearsExperience >= 5 && testPlayer.careerRegularSeasonTradStats.points >= 15 {
            self.statsScore += 1
            print("Score boosted to \(self.statsScore) for being a high scoring player for at least 5 years")
        }
        
    }
    
}
