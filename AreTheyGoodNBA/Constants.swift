//
//  Constants.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

let BASE_URL = "https://stats.nba.com/stats/"

typealias DownloadComplete = () -> ()

//Endpoints

let PLAYER_INFO = "commonplayerinfo/?"
let TEAM_ROSTER = "commonteamroster/?"
let TEAM_HISTORY = "franchisehistory/?"
let PLAYER_CAREER_STATS = "playercareerstats/?"
let TEAM_SEASON_STATS = "teamdashboardbygeneralsplits/?"
let PLAYER_SEASON_STATS = "playerdashboardbyyearoveryear/?"

//Parameters - Static

let MEASURE_TYPE_ADVANCED = "MeasureType=Advanced&"
let MEASURE_TYPE_BASE = "MeasureType=Base&"
let PER_MODE_GAME = "PerMode=PerGame&"
let PER_MODE_36 = "PerMode=Per36&"
let PLUS_MINUS_YES = "PlusMinus=Y&"
let PLUS_MINUS_NO = "PlusMinus=N&"
let RANK = "Rank=N&"
let SEASON_TYPE_REGULAR = "SeasonType=Regular+Season&"
let SEASON_TYPE_POST = "SeasonType=Playoffs&"
let PO_ROUND = "PORound=0&"
let OUTCOME = "Outcome=&"
let LOCATION = "Location=&"
let MONTH = "Month=0&"
let SEASON_SEGMENT = "SeasonSegment=&"
let DATE_FROM = "DateFrom=&"
let DATE_TO = "DateTo=&"
let OPPONENT_TEAM_ID = "OpponentTeamID=0&"
let VS_CONFERENCE = "VsConference=&"
let VS_DIVISION = "VsDivision=&"
let GAME_SEGMENT = "GameSegment=&"
let PERIOD = "Period=0&"
let SHOT_CLOCK_RANGE = "ShotClockRange=&"
let LAST_N_GAMES = "LastNGames=0&"
let LEAGUE_ID = "LeagueID=00&"
let PACE_ADJUST_YES = "PaceAdjust=Y&"
let PACE_ADJUST_NO = "PaceAdjust=N&"
let SEASON_YEAR_CURRENT = "2017-18"
let CURRENT_SEASON = "Season=\(SEASON_YEAR_CURRENT)&"

//Parameters - Variable

let SEASON_SELECT = "Season="
let PLAYER_ID = "PlayerID="
let TEAM_ID = "TeamID="

enum MeasureType {
    
    case RegularBase
    case RegularAdvanced
    case PostBase
    case PostAdvanced
    
}




