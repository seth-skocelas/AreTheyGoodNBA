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
    
    func getCommonPlayerInfo(playerID: Int) {
        
        let urlString = "\(BASE_URL)\(PLAYER_INFO)\(PLAYER_ID)\(playerID)"
        print(urlString)
        
    }
    
    func getCommonTeamRoster(teamID: Int) {
        
        let urlString = "\(BASE_URL)\(TEAM_ROSTER)\(CURRENT_SEASON)\(TEAM_ID)\(teamID)"
        print(urlString)
        
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

