//
//  PlayerImage.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 7/29/19.
//  Copyright © 2019 Seth Skocelas. All rights reserved.
//

import Foundation
import UIKit

class ClassTypeImage {
    
    private var _team: Team!
    private var _player: Player!
    private var _image: UIImage!
    private var _classType: ClassType!
    private var _imageSet = false
    
    var Image: UIImage {
        
        if _image == nil {
            return UIImage()
        }
        return _image
    }
    
    var ImageSet: Bool {
        return _imageSet
    }
    
    init() { }
    
    init(team: Team) {
        
        _classType = ClassType.Team
        _team = team
        
        WebService.instance.teamGroup.enter()
        WebService.instance.getWebImage(urlString: getTeamImageURL(), isSVG: true) { (image) in
            self._image = image;
            self._imageSet = true
            WebService.instance.teamGroup.leave()
        }
        
    }
    
    init(player: Player) {
        
        _classType = ClassType.Player
        _player = player
        
        WebService.instance.playerGroup.enter()
        WebService.instance.getWebImage(urlString: getPlayerImageURL(), isSVG: false) { (image) in
            self._image = image;
            self._imageSet = true
            WebService.instance.playerGroup.leave()
        }
        
    }
    
    func getPlayerImageURL() -> String {
        
        var urlString = ""
    
        if let player = self._player {
            
            let teamID = player.teamID
            if WebService.instance.currentLeague == LeagueName.WNBA {
                urlString = "\(WNBA_PICTURE_URL)"
            } else {
                urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            }
            let playerID = player.playerID
            
            return "\(urlString)\(playerID).png"

        }
        return ""
    }
    
    func getTeamImageURL() -> String {
        
        if let team = self._team {
            
            if team.leagueName == LeagueName.WNBA
            {
                return "\(WNBA_LOGO_URL)\(team.teamAbbreviation)\(WNBA_LOGO_INFO_URL)"
            }
            return "\(BASE_LOGO_URL)\(team.teamAbbreviation)\(LOGO_INFO_URL)"
        }
        return ""
    }
    
}
