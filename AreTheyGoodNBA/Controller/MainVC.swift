//
//  MainVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/7/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //WebService.instance.getCommonPlayerInfo(playerID: 201935) {}
        //WebService.instance.getCommonTeamRoster(teamID: 1610612745) {}
        //WebService.instance.getFranchiseHistory() {}
        //WebService.instance.getPlayerCareerStats(playerID: 201935)
        WebService.instance.getTeamSeasonStats(teamID: 1610612745, measureType: MeasureType.RegularAdvanced) {}
        //WebService.instance.getPlayerSeasonStats(playerID: 201935)
        
    }




}

