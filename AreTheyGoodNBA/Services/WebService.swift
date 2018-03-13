//
//  WebService.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation
import Alamofire

class WebService {
    
    static let instance = WebService()
    
    func getCommonPlayerInfo(playerID: Int, completed: @escaping DownloadComplete) {
        
        let urlString = "\(BASE_URL)\(PLAYER_INFO)\(PLAYER_ID)\(playerID)"
        //print(urlString)
        let queryURL = URL(string: urlString)!
        
        Alamofire.request(queryURL).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {

                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let commonPlayerInfo = resultSets[0]
                
                let headers = commonPlayerInfo["headers"] as! [AnyObject]
                print(headers[0])
                
                let rowSet = commonPlayerInfo["rowSet"] as! [AnyObject]
                let rowSetValues = rowSet[0] as! [AnyObject]
                print(rowSetValues[0])
                
                var commonPlayerInfoDict = Dictionary<String, AnyObject>()
                
                for i in 0 ..< headers.count {
                    commonPlayerInfoDict.updateValue(rowSetValues[i], forKey: headers[i] as! String)
                }
                
                print(commonPlayerInfoDict)
                
            }
            
            completed()
        }
        
    }
    
    func getCommonTeamRoster(teamID: Int, completed: @escaping DownloadComplete) {
        
        let urlString = "\(BASE_URL)\(TEAM_ROSTER)\(CURRENT_SEASON)\(TEAM_ID)\(teamID)"
        //print(urlString)
        let queryURL = URL(string: urlString)!
        
        Alamofire.request(queryURL).responseJSON { response in
            
            let result = response.result
            
            if let baseDict = result.value as? Dictionary<String, AnyObject> {
                
                let resultSets = baseDict["resultSets"] as! [Dictionary<String, AnyObject>]
                let commonTeamRoster = resultSets[0]
                
                let headers = commonTeamRoster["headers"] as! [AnyObject]
                
                let rowSet = commonTeamRoster["rowSet"] as! [AnyObject]
                
                
                var commonTeamRosterArray = [AnyObject]()
                
                for i in 0 ..< rowSet.count {
                    
                    let rowSetValues = rowSet[i] as! [AnyObject]
                    var teamPlayerDict = Dictionary<String, AnyObject>()
                    
                    for j in 0 ..< headers.count {
                        teamPlayerDict.updateValue(rowSetValues[j], forKey: headers[j] as! String)
                    }
                    
                    commonTeamRosterArray.append(teamPlayerDict as AnyObject)
                    
                }
                
                print(commonTeamRosterArray)
                
            }
            
            completed()
        }
        
    }
    
    func getFranchiseHistory() {
        
        let urlString = "\(BASE_URL)\(TEAM_HISTORY)\(LEAGUE_ID)"
        print(urlString)
        
    }
    
    func getPlayerCareerStats(playerID: Int) {
        
        let urlString = "\(BASE_URL)\(PLAYER_CAREER_STATS)\(PER_MODE_GAME)\(PLAYER_ID)\(playerID)"
        print(urlString)
        
    }
    
    func getTeamSeasonStats(teamID: Int) {
        
        let urlRegularAdvanced = "\(BASE_URL)\(TEAM_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
        
        let urlRegularBase = "\(BASE_URL)\(TEAM_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
        
        let urlPlayoffsAdvanced = "\(BASE_URL)\(TEAM_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
        
        let urlPlayoffsBase = "\(BASE_URL)\(TEAM_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(TEAM_ID)\(teamID)"
        
        print(urlPlayoffsBase)
        
    }
    
    func getPlayerSeasonStats(playerID: Int) {
        
        let urlRegularAdvanced = "\(BASE_URL)\(PLAYER_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"

        let urlRegularBase = "\(BASE_URL)\(PLAYER_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_REGULAR)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
        
        let urlPlayoffsAdvanced = "\(BASE_URL)\(PLAYER_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_ADVANCED)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(playerID)"
        
        let urlPlayoffsBase = "\(BASE_URL)\(PLAYER_SEASON_STATS)\(CURRENT_SEASON)\(SEASON_TYPE_POST)\(LEAGUE_ID)\(MEASURE_TYPE_BASE)\(PER_MODE_GAME)\(PLUS_MINUS_NO)\(PACE_ADJUST_NO)\(RANK)\(OUTCOME)\(LOCATION)\(MONTH)\(SEASON_SEGMENT)\(DATE_FROM)\(DATE_TO)\(OPPONENT_TEAM_ID)\(VS_CONFERENCE)\(VS_DIVISION)\(GAME_SEGMENT)\(PERIOD)\(LAST_N_GAMES)\(PLAYER_ID)\(playerID)"
        
        print(urlRegularBase)
        
    }
    
    
}

