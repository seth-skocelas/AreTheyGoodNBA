//
//  Constants.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/10/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

let BASE_URL = "https://stats.nba.com/stats/"
let BASE_PICTURE_URL = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/"
let PICTURE_INFO_URL = "/\(PICTURE_YEAR)/260x190/"
let BASE_LOGO_URL = "http://stats.nba.com/media/img/teams/logos/"
let LOGO_INFO_URL = "_logo.svg"

typealias DownloadComplete = () -> ()
typealias PlayerStatsTuple = (player: Player, statDuration: StatDuration)
typealias TeamStatsTuple = (team: Team, statDuration: StatDuration)

//Endpoints

let PLAYER_INFO = "commonplayerinfo/?"
let TEAM_ROSTER = "commonteamroster/?"
let TEAM_HISTORY = "franchisehistory/?"
let PLAYER_CAREER_STATS = "playercareerstats/?"
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
let SEASON_YEAR_CURRENT = "2018-19"
let PICTURE_YEAR = "2018"
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

let seasonSelectArray = [
    SEASON_YEAR_CURRENT,
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

//Special Responses

let specialResponseDict: [Int: String] = [
    202681: "As good as the earth is round.",
    2544: "King James is a top 2 player of all time, you don't need an app to tell you that.",
    1717: "Dirk is the best European player of all time. He just can't move anymore.",
    201939: "Yes, the best shooter of all time is a good player.",
    201142: "In the summer of 2016, Kevin Durant took the hardest road. I'll let you decide.",
    101108: "He's a conference finalist. Of course he's good!",
    201935: "He's great so long as he doesn't have to carry a playoff team by himself.",
    203507: "The Greek Freak is the future.",
    203076: "The Unibrow is one of the best players in the NBA, even if no one is watching his games.",
    201566: "Any player that averages a triple double has to be good, right?",
    203954: "Trust the process.",
    202695: "The man can defend LeBron. Clearly he's talented.",
    201942: "LeBron wouldn't think so."
]







