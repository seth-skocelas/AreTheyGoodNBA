//
//  Model.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class PlayerModel {
    
    let goodCutoff = 0.5
    
    var isSecondary = false
    var statsScore = 0.0
    var result = Result.Inconclusive
    var scoreDict = Dictionary<String, Int>()
    
    var testStatDuration: StatDuration = StatDuration.CurrentSeason
    var testPlayer: Player
    
    var playerRegularTradStats: TradStats!
    var playerRegularAdvStats: AdvStats!
    
    init(player: Player, statDuration: StatDuration, isSecondary: Bool) {
        
        self.testPlayer = player
        self.testStatDuration = statDuration
        self.isSecondary = isSecondary
        
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
    
    func calculateResult() {
        
        if testStatDuration == StatDuration.Career && statsScore < goodCutoff {
            self.careerLegendCheck()
        }
            
        if self.inconclusiveData() == false {
                
            if statsScore >= goodCutoff {
                result = Result.Yes
            } else {
                result = Result.No
            }
            
        } else {
            result = Result.Inconclusive
        }
        
        print("\(testPlayer.playerID)\n")
        
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
    
    func inconclusiveData() -> Bool {
        
        let gamesPlayed = playerRegularTradStats.gamesPlayed
        let minutesPlayed = playerRegularTradStats.minutesPlayed * Double(gamesPlayed)
        let attempts = playerRegularTradStats.fieldGoalAttempts * Double(gamesPlayed)
        
        if gamesPlayed <= 10 || minutesPlayed <= 100 || attempts <= 50 {
            return true
        }
        
        return false
        
    }
    
    func scoreAdjustment(optionalModel: PlayerModel) {
        
        if isSecondary {
            
            print("No Adjustment because this is the secondary model.\n")
            
        } else {
            
            statsScore = (statsScore + optionalModel.statsScore)/2
            print("Averaging Primary and Secondary results.\n")
            
        }
        
    }
    
    

    
    func scoreAdjustment(optionalModel: PlayerModel, thirdModel: PlayerModel) {
        
        if isSecondary {
            
            print("No Adjustment because this is the secondary model.\n")
            
        } else {
            
            var secondaryModel: PlayerModel = optionalModel
            
            if optionalModel.statsScore <  thirdModel.statsScore {
                secondaryModel = thirdModel
                print("Averaging Primary and Third results.\n")
            }
            print("Averaging Primary and Secondary results.\n")
            
            statsScore = (statsScore + secondaryModel.statsScore)/2
            
        }
        
    }

    
}
