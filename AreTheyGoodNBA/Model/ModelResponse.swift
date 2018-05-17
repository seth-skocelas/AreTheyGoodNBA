//
//  ModelResponse.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 5/16/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import Foundation


class ModelResponse {
    
    var playerModel: PlayerModel!
    
    //Static First Line Strings
    
    let husFirst = "based on his production as a high-usage starter."
    let starterFirst = "based on his production as a starter."
    let roleFirst = "based on his production as a role player."
    let fringeFirst = "based on his production as a fringe player."
    let unknownFirst = "did not play enough to be judged by the model."
    
    init(model: PlayerModel) {
        playerModel = model
    }
    
    func firstLine() -> String {
        return ""
    }
    
    
    
}
