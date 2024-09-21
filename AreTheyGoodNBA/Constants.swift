//
//  Constants.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

let BASE_URL = "https://stats.nba.com/stats/"
let WNBA_BASE_URL = "https://stats.wnba.com/stats/"
let BASE_PICTURE_URL = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/"
let WNBA_PICTURE_URL = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/wnba/latest/1040x760/"
let PICTURE_INFO_URL = "/\(PICTURE_YEAR)/260x190/"
let BASE_LOGO_URL = "http://stats.nba.com/media/img/teams/logos/"
let WNBA_LOGO_URL = "https://stats.wnba.com/media/img/teams/logos/"
let LOGO_INFO_URL = "_logo.svg"
let WNBA_LOGO_INFO_URL = ".svg"

typealias DownloadComplete = () -> ()
typealias PlayerStatsTuple = (player: Player, statDuration: StatDuration)
typealias TeamStatsTuple = (team: Team, statDuration: StatDuration)

//Endpoints

let PLAYER_INFO = "commonplayerinfo/?"
let TEAM_ROSTER = "commonteamroster/?"
let TEAM_HISTORY = "franchisehistory?"
let PLAYER_CAREER_STATS = "playercareerstats?"
let TEAM_SEASON_STATS = "teamdashboardbygeneralsplits/?"
let PLAYER_SEASON_STATS = "playerdashboardbyyearoveryear/?"
let LEAGUE_STANDINGS = "leaguestandingsv3?"

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
let SEASON_YEAR_CURRENT = "2024-25"
let SEASON_YEAR_CURRENT_WNBA = "2024"
let PICTURE_YEAR = "2023"
let CURRENT_SEASON = "Season=\(SEASON_YEAR_CURRENT)&"

//Parameters - Variable

let SEASON_SELECT = "Season="
let PLAYER_ID = "PlayerID="
let TEAM_ID = "TeamID="

enum LeagueName {
    case NBA
    case WNBA
}

enum MeasureType {
    
    case RegularBase
    case RegularAdvanced
    case PostBase
    case PostAdvanced
    
}

enum StatDuration {
    
    case CurrentSeason
    case Career
    
}

enum ClassType {
    
    case Player
    case Team
    
}

enum Position {
    
    case Guard
    case GuardForward
    case Forward
    case ForwardCenter
    case Center
    case None
    
}

enum Result {
    
    case Yes
    case No
    case Inconclusive
    
}

//Team Abbreviation Array

let teamAbbrevaiationArray = [
    "ATL",
    "BOS",
    "BKN",
    "CHA",
    "CHI",
    "CLE",
    "DAL",
    "DEN",
    "DET",
    "GSW",
    "HOU",
    "IND",
    "LAC",
    "LAL",
    "MEM",
    "MIA",
    "MIL",
    "MIN",
    "NOP",
    "NYK",
    "OKC",
    "ORL",
    "PHI",
    "PHX",
    "POR",
    "SAC",
    "SAS",
    "TOR",
    "UTA",
    "WAS"
]

let teamAbbrevaiationWNBAArray = [
    "ATL",
    "CHI",
    "CON",
    "DAL",
    "IND",
    "LVA",
    "LAS",
    "MIN",
    "NYL",
    "PHO",
    "SEA",
    "WAS"
]

let leagueSelectArray = [
    "NBA",
    "WNBA"
]

let seasonSelectArray = [
    SEASON_YEAR_CURRENT,
    "2023-24",
    "2022-23",
    "2021-22",
    "2020-21",
    "2019-20",
    "2018-19",
    "2017-18",
    "2016-17",
    "2015-16",
    "2014-15",
    "2013-14",
    "2012-13",
    "2011-12",
    "2010-11",
    "2009-10",
    "2008-09",
    "2007-08",
    "2006-07",
    "2005-06",
    "2004-05",
    "2003-04",
    "2002-03",
    "2001-02",
    "2000-01",
    "1999-00",
    "1998-99",
    "1997-98",
    "1996-97"
]

let seasonWNBASelectArray = [
    SEASON_YEAR_CURRENT_WNBA,
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007",
    "2006",
    "2005",
    "2004",
    "2003",
    "2002",
    "2001",
    "2000",
    "1999",
    "1998",
    "1997"
]

//Special Responses

let specialResponseDict: [Int: String] = [
    202681: "As good as the earth is round.",
    2544: "King James is a top 2 player of all time, you don't need an app to tell you that.",
    201939: "Yes, the best shooter of all time is a good player.",
    201142: "In the summer of 2016, Kevin Durant took the hardest road. I'll let you decide.",
    203507: "The Greek Freak is the future."
]







