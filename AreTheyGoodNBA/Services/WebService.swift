//
//  WebService.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation
import Alamofire
import SVGKit

class WebService {
    
    static let instance = WebService()
    
    let leagueGroup = DispatchGroup()
    let teamGroup = DispatchGroup()
    let playerGroup = DispatchGroup()
    
    let headers: HTTPHeaders = ["Referer": "https://stats.nba.com", "x-nba-stats-origin": "stats", "x-nba-stats-token": "true"]
    
    var SELECTED_SEASON = "Season=\(SEASON_YEAR_CURRENT)&"
    
    func getCommonPlayerInfo(playerID: Int, completed: @escaping (_ commonPlayerInfoDict: Dictionary<String, AnyObject>) -> ()) {
        
        let urlString = "\(BASE_URL)\(PLAYER_INFO)\(PLAYER_ID)\(playerID)"
        //print(urlString)
        let queryURL = URL(string: urlString)!
        
        var commonPlayerInfoDict = Dictionary<String, AnyObject>()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {

                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let commonPlayerInfo = resultSets[0]
                
                let headers = commonPlayerInfo["headers"] as! [AnyObject]
                //print(headers[0])
                
                let rowSet = commonPlayerInfo["rowSet"] as! [AnyObject]
                let rowSetValues = rowSet[0] as! [AnyObject]
                //print(rowSetValues[0])
                
                for i in 0 ..< headers.count {
                    commonPlayerInfoDict.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                }
                
                //print(commonPlayerInfoDict)
                
            }
            
            completed(commonPlayerInfoDict)
        }
        
    }
    
    func getCommonTeamRoster(teamID: Int, completed: @escaping (_ teamArray: [Dictionary<String, AnyObject>]) -> ()) {
        
        let urlString = "\(BASE_URL)\(TEAM_ROSTER)\(SELECTED_SEASON)\(TEAM_ID)\(teamID)"
        //print(urlString)
        let queryURL = URL(string: urlString)!
        
        var commonTeamRosterArray = [Dictionary<String, AnyObject>]()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let commonTeamRoster = resultSets[0]
                
                let headers = commonTeamRoster["headers"] as! [AnyObject]
                
                let rowSet = commonTeamRoster["rowSet"] as! [AnyObject]
                
                for i in 0 ..< rowSet.count {
                    
                    let rowSetValues = rowSet[i] as! [AnyObject]
                    var teamPlayerDict = Dictionary<String, AnyObject>()
                    
                    for j in 0 ..< headers.count {
                        teamPlayerDict.updateValue(rowSetValues[j], forKey: headers[j] as! String)
                    }
                    
                    commonTeamRosterArray.append(teamPlayerDict)
                    
                }
                
                //print(commonTeamRosterArray)
                
            }
            
            completed(commonTeamRosterArray)
        }
        
    }
    
    func getFranchiseHistory(completed: @escaping (_ franchiseHistoryArray: [AnyObject]) -> ()) {
        
        let urlString = "\(BASE_URL)\(TEAM_HISTORY)\(LEAGUE_ID)"
        //print(urlString)
        let queryURL = URL(string: urlString)!
        
        var franchiseHistoryArray = [AnyObject]()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let franchiseHistory = resultSets[0]
                
                let headers = franchiseHistory["headers"] as! [AnyObject]
                
                let rowSet = franchiseHistory["rowSet"] as! [AnyObject]
                
                for i in 0 ..< rowSet.count {
                    
                    let rowSetValues = rowSet[i] as! [AnyObject]
                    var franchiseDict = Dictionary<String, AnyObject>()
                    
                    for j in 0 ..< headers.count {
                        franchiseDict.updateValue(rowSetValues[j], forKey: headers[j] as! String)
                    }
                    
                    franchiseHistoryArray.append(franchiseDict as AnyObject)
                    
                }
                
                //print(franchiseHistoryArray)
                
            }
            
            completed(franchiseHistoryArray)
        }
        
    }
    
    func getTeamStandings(completed: @escaping (_ teamStandingsArray: [AnyObject]) -> ()) {
        
        let urlString = "\(BASE_URL)\(LEAGUE_STANDINGS)\(LEAGUE_ID)\(SELECTED_SEASON)\(SEASON_TYPE_REGULAR)"
        
        let queryURL = URL(string: urlString)!
        
        var standingsArray = [AnyObject]()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let standings = resultSets[0]
                
                let headers = standings["headers"] as! [AnyObject]
                
                let rowSet = standings["rowSet"] as! [AnyObject]
                
                for i in 0 ..< rowSet.count {
                    
                    let rowSetValues = rowSet[i] as! [AnyObject]
                    var standingsDict = Dictionary<String, AnyObject>()
                    
                    for j in 0 ..< headers.count {
                        standingsDict.updateValue(rowSetValues[j], forKey: headers[j] as! String)
                    }
                    
                    standingsArray.append(standingsDict as AnyObject)
                    
                }
                
                //print(franchiseHistoryArray)
                
            }
            
            completed(standingsArray)
        }
        
        
    }
    
    func getPlayerCareerStats(playerID: Int, completed: @escaping (_ playerCareerRegularStats: Dictionary<String, AnyObject>,_ playerCareerPlayoffStats: Dictionary<String, AnyObject> ) -> ()) {
        
        let urlString = "\(BASE_URL)\(PLAYER_CAREER_STATS)\(LEAGUE_ID)\(PER_MODE_GAME)\(PLAYER_ID)\(playerID)"
        let queryURL = URL(string: urlString)!
        
        var playerCareerRegularStats = Dictionary<String, AnyObject>()
        var playerCareerPlayoffStats = Dictionary<String, AnyObject>()
        
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let careerTotalsRegularSeason = resultSets[1]
                
                var headers = careerTotalsRegularSeason["headers"] as! [AnyObject]
                
                var rowSet = careerTotalsRegularSeason["rowSet"] as! [AnyObject]
                
                if rowSet.isEmpty == false {
                    
                    var rowSetValues = rowSet[0] as! [AnyObject]
                    
                    
                    for i in 0 ..< headers.count {
                        playerCareerRegularStats.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                    }
                    
                    //print(overallPlayerStatsDict)
                }
                
                let careerTotalsPostSeason = resultSets[3]
                
                headers = careerTotalsPostSeason["headers"] as! [AnyObject]
                
                rowSet = careerTotalsPostSeason["rowSet"] as! [AnyObject]
                
                if rowSet.isEmpty == false {
                    
                    var rowSetValues = rowSet[0] as! [AnyObject]
                    
                    
                    for i in 0 ..< headers.count {
                        playerCareerPlayoffStats.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                    }
                    
                    //print(overallPlayerStatsDict)
                }
                
            }
            print("Completed: \(urlString)")
            completed(playerCareerRegularStats, playerCareerPlayoffStats)
        }
        
        
    }
    
    //refactor this (consolidate url string, switch statement)
    
    func getTeamSeasonStatsURL(teamID: Int, measureType: MeasureType) -> String {
        
        if measureType == MeasureType.RegularAdvanced {
        
            return "\(BASE_URL)\(TEAM_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
    
        }
        
        else if measureType == MeasureType.PostBase {
            
            return "\(BASE_URL)\(TEAM_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
            
        }
        
        else if measureType == MeasureType.PostAdvanced {
            
            return "\(BASE_URL)\(TEAM_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
            
        }
        
        else { //return RegularBase
            
            return "\(BASE_URL)\(TEAM_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
        }
        
    }
    
    func getTeamSeasonStats(teamID: Int, measureType: MeasureType, completed: @escaping (_ teamStats: Dictionary<String, AnyObject>) -> ()) {
        
        let urlString = getTeamSeasonStatsURL(teamID: teamID, measureType: measureType)
        let queryURL = URL(string: urlString)!
        var overallTeamDashboardDict = Dictionary<String, AnyObject>()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let overallTeamDashboard = resultSets[0]
                
                let headers = overallTeamDashboard["headers"] as! [AnyObject]
                //print(headers[0])
                
                let rowSet = overallTeamDashboard["rowSet"] as! [AnyObject]
                
                if rowSet.isEmpty == false {
                
                    let rowSetValues = rowSet[0] as! [AnyObject]
                    //print(rowSetValues[0])
                
                    for i in 0 ..< headers.count {
                        overallTeamDashboardDict.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                    }
                
                    //print(overallTeamDashboardDict)
                    
                }
                
            }
            
            completed(overallTeamDashboardDict)
        }
        
    }
    
    func getPlayerSeasonStatsURL(playerID: Int, measureType: MeasureType) -> String {
        
        
        if measureType == MeasureType.RegularAdvanced {
            
            return "\(BASE_URL)\(PLAYER_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
            
        }
            
        else if measureType == MeasureType.PostBase {
            
            return "\(BASE_URL)\(PLAYER_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
            
        }
            
        else if measureType == MeasureType.PostAdvanced {
            
            return "\(BASE_URL)\(PLAYER_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
            
        }
            
        else { //return RegularBase
            
            return "\(BASE_URL)\(PLAYER_SEASON_STATS)\(SELECTED_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
        }
        
        
    }
    
    func getPlayerSeasonStats(playerID: Int, measureType: MeasureType, completed: @escaping (_ overallSeasonDict: Dictionary<String, AnyObject>,_ playerYearStats: [AnyObject] ) -> ()) {
        
        let urlString = getPlayerSeasonStatsURL(playerID: playerID, measureType: measureType)
        let queryURL = URL(string: urlString)!
        
        var overallPlayerStatsDict = Dictionary<String, AnyObject>()
        var playerYearStatsArray = [AnyObject]()
        
        Alamofire.request(queryURL, headers: headers).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                
                let overallStats = resultSets[0]
                var headers = overallStats["headers"] as! [AnyObject]
                
                var rowSet = overallStats["rowSet"] as! [AnyObject]
                
                if rowSet.isEmpty == false {
                
                    var rowSetValues = rowSet[0] as! [AnyObject]
                
                
                    for i in 0 ..< headers.count {
                        overallPlayerStatsDict.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                    }
                
                    //print(overallPlayerStatsDict)
                    
                }
                
                let playerYearStats = resultSets[1]
                headers = playerYearStats["headers"] as! [AnyObject]
                
                rowSet = playerYearStats["rowSet"] as! [AnyObject]
                
                if rowSet.isEmpty == false {
                
                    for i in 0 ..< rowSet.count {
                        
                        let rowSetValues = rowSet[i] as! [AnyObject]
                        var playerYearDict = Dictionary<String, AnyObject>()
                        
                        for j in 0 ..< headers.count {
                            playerYearDict.updateValue(rowSetValues[j], forKey: headers[j] as! String)
                            }
                        
                        playerYearStatsArray.append(playerYearDict as AnyObject)
                        
                        }
                    
                    //print(playerYearStatsArray)
            
                }
                
            }
            print("Completed: \(urlString)")
            completed(overallPlayerStatsDict, playerYearStatsArray)
        }
        
    }
    
    func getWebImage(urlString : String, isSVG: Bool, completed: @escaping (_ image: UIImage ) -> ()) {
        
        guard let url = URL(string: urlString) else {return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                completed(UIImage())
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                completed(UIImage())
                return
            }
            
            DispatchQueue.main.async {
                
                if isSVG {
                    if let svgImage = SVGKImage(data: data!) {
                        completed(svgImage.uiImage)
                    } else {
                        print("SVG not loaded")
                        completed(UIImage())
                    }
                } else {
                    completed(UIImage(data: data!)!)
                }
            }
            }.resume()
        
    }
    
}

