//
//  CSVCreation.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 7/28/19.
//  Copyright © 2019 Seth Skocelas. All rights reserved.
//

import Foundation

public final class CSVCreation {
    
    private init() {}
    
    static func CreatePlayerStatsCSV() {
    
        let currentFileName = "CurrentPlayerStats.csv"
        let currentPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(currentFileName)
        
        let careerFileName = "CareerPlayerStats.csv"
        let careerPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(careerFileName)
        
        let header = "ID,Player Name,Team,Years,Position,GamesPlayed,MinutesPlayed,3PT%,3PTM,3PTA,FG%,FGM,FGA,PTS,REB,AST,TO,+/-,OffRating,DefRating,NetRating,EFG%,TS%,USG,PACE,PIE,Inconclusive,Score\n"
        
        do {
            try header.write(to: currentPath!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        do {
            try header.write(to: careerPath!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    
    }
    
    static func exportPlayerStats(currentPlayerModel : PlayerModel) {
        
        let p = currentPlayerModel.testPlayer
        let statDuration = currentPlayerModel.testStatDuration
        let finalResult = currentPlayerModel.finalResult
        let statsScore = currentPlayerModel.statsScore
        
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
        
        if finalResult == Result.Inconclusive {
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
