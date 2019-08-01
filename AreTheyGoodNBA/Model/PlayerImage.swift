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
    
    init(team: Team) {
        
        _classType = ClassType.Team
        _team = team
        
    }
    
    init(player: Player) {
        
        _classType = ClassType.Player
        _player = player
        
        WebService.instance.playerGroup.enter()
        WebService.instance.getWebImage(urlString: getPlayerImageURL()) { (image) in
            self._image = image;
            WebService.instance.playerGroup.leave()
        }
        
    }
    
    func getPlayerImageURL() -> String {
        
        var urlString = ""
    
        if let player = self._player {
            
            let teamID = player.teamID
            urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            let playerID = player.playerID
            
            return "\(urlString)\(playerID).png"

        }
        return ""
    }
}
