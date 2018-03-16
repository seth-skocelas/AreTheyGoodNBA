//
//  Player.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/15/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class Player {
    
    private var _name: String!
    private var _playerID: Int!  //nba.com ID
    private var _height: String!
    private var _weight: String!
    private var _yearsExperience: Int!
    private var _jerseyNumber: String!
    private var _position: String!
    private var _currentTeam: String!
    private var _startingYear: String!
    
    private var currentRegularSeasonTradStats: PlayerTradStats!
    private var currentPostSeasonTradStats: PlayerTradStats!
    
    var name: String {
        return _name
    }
    
    var playerID: Int {
        return _playerID
    }
    
    var yearsExperience: Int {
        if _yearsExperience == nil {
            return -1
        }
        return _yearsExperience
    }
    
    var jerseyNumber: String {
        if _jerseyNumber == nil {
            return ""
        }
        return _jerseyNumber
    }
    
    var position: String {
        if _position == nil {
            return ""
        }
        return _position
    }
    
    var currentTeam: String {
        if _currentTeam == nil {
            return ""
        }
        return _currentTeam
    }
    
    var startingYear: String {
        if _startingYear == nil {
            return ""
        }
        return _startingYear
    }
    
    
    //Get data from nba.com API dictionary
    init(commonPlayerInfo: Dictionary<String, AnyObject>) {
        
        _name = commonPlayerInfo["DISPLAY_FIRST_LAST"] as! String
        _playerID = commonPlayerInfo["PERSON_ID"] as! Int
        _height = commonPlayerInfo["HEIGHT"] as! String
        _weight = commonPlayerInfo["WEIGHT"] as! String
        _yearsExperience = commonPlayerInfo["SEASON_EXP"] as! Int
        _jerseyNumber = commonPlayerInfo["JERSEY"] as! String
        _position = commonPlayerInfo["POSITION"] as! String
        _currentTeam = "\(commonPlayerInfo["TEAM_CITY"] as! String) \(commonPlayerInfo["TEAM_NAME"] as! String)"
        _startingYear = commonPlayerInfo["DRAFT_YEAR"] as! String
        
        
    }
    
}
