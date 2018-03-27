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
        
        let league = League()

        
        //2544 = Lebron
        //1628372 = DSJ
        
        //WebService.instance.getCommonPlayerInfo(playerID: 2544) { (commonPlayerInfoDict) in

            //var testPlayer = Player(commonPlayerInfo: commonPlayerInfoDict)
            //print("\(testPlayer.name) with id of \(testPlayer.playerID) on the \(testPlayer.currentTeam)" )
            //print("CareerFGReg: \(testPlayer.careerRegularSeasonTradStats.fieldGoalPercent), CareerFGPost: \(testPlayer.careerPostSeasonTradStats.fieldGoalPercent)")

        //}
        //WebService.instance.getCommonTeamRoster(teamID: 1610612745) {}
        //WebService.instance.getFranchiseHistory() {}
        //WebService.instance.getPlayerCareerStats(playerID: 201935)
        //WebService.instance.getTeamSeasonStats(teamID: 1610612745, measureType: MeasureType.RegularAdvanced) {}
//        WebService.instance.getPlayerSeasonStats(playerID: 201935, measureType: MeasureType.RegularBase) { (currentSeason, allSeasons) in
//
//            var testPlayerSeasonStats = TradStats(statType: MeasureType.RegularBase, statDuration: StatDuration.CurrentSeason, dict: currentSeason)
//            print("Test: \(testPlayerSeasonStats.gamesPlayed), \(testPlayerSeasonStats.fieldGoalPercent)")
//
//        }
//
    }




}

