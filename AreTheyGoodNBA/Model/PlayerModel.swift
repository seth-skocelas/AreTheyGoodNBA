//
//  Model.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/18/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class PlayerModel {
    
    //default good/notgood score determination. This will be updated on creation based on CurrentSeason/Career
    
    var goodCutoff = 0.4995
    
    
    var isSecondary = false
    var statsScore = 0.0
    var finalResult = Result.Inconclusive
    var inconclusiveResult = Result.No
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
            
            //Season-end average score for all non-inconclusive players in 17-18 season was .443
            goodCutoff = 0.44
            
        } else if statDuration == StatDuration.Career {
            
            playerRegularTradStats = self.testPlayer.careerRegularSeasonTradStats
            playerRegularAdvStats = self.testPlayer.careerRegularSeasonAdvStats
            
            //Season-end average career score for all non-inconclusive players in 17-18 season was .382
            goodCutoff = 0.38
            
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
                finalResult = Result.Yes
            } else {
                finalResult = Result.No
            }
            
        } else {
            
            finalResult = Result.Inconclusive
            
            if statsScore >= goodCutoff {
                inconclusiveResult = Result.Yes
            } else {
                inconclusiveResult = Result.No
            }
        }
        
        CSVCreation.exportPlayerStats(currentPlayerModel: self)
        
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
    
    func exportStats(statDuration: StatDuration) {
        
        let p = testPlayer
        var path: URL
        var ct: TradStats
        var ca: AdvStats
        
        if statDuration == StatDuration.CurrentSeason {
        
            let fileName = "CurrentPlayerStats.csv"
            path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
            
            ct = p.currentRegularSeasonTradStats
            ca = p.currentRegularSeasonAdvStats
        
        } else {
            
            let fileName = "CareerPlayerStats.csv"
            path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
            
            ct = p.careerRegularSeasonTradStats
            ca = p.careerRegularSeasonAdvStats
        }
            
        var inconclusive = "No"
        
        if self.finalResult == Result.Inconclusive {
            inconclusive = "Yes"
        }
        
        let stats = "\(p.playerID),\(p.name),\(p.currentTeam),\(p.yearsExperience),\(p.position),\(ct.gamesPlayed),\(ct.minutesPlayed),\(ct.threePointPercent),\(ct.threePointPerMin),\(ct.threePointAttempts),\(ct.fieldGoalPercent),\(ct.fieldGoalPerMin),\(ct.fieldGoalAttempts),\(ct.points),\(ct.rebounds),\(ct.assists),\(ct.turnovers),\(ct.plusMinus),\(ca.offRating),\(ca.defRating),\(ca.netRating),\(ca.effectiveFG),\(ca.trueShooting),\(ca.usage),\(ca.pace),\(ca.PIE),\(inconclusive),\(statsScore)\n"
        
        do {
            try stats.append(to: path)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
    }

    
}
