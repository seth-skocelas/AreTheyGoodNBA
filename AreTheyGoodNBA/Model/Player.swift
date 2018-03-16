//
//  Player.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/15/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation

class Player {
    
    private var _name: String
    private var _playerID: Int  //nba.com ID
    private var _height: String!
    private var _weight: String!
    private var _yearsExperience: Int!
    private var _jerseyNumber: Int!
    private var _position: String!
    private var _currentTeam: String!
    private var _startingYear: String!
    
    var name: String {
        return _name
    }
    
    var playerID: Int {
        return _playerID
    }
    
    init(name: String, playerID: Int) {
        
        _name = name
        _playerID = playerID
        
    }
    
    init(commonPlayerInfo: Dictionary<String, AnyObject>) {
        
        //set all values here
        
        _name = commonPlayerInfo["DISPLAY_FIRST_LAST"] as! String
        _playerID = commonPlayerInfo["PERSON_ID"] as! Int
        
    }
    
}
