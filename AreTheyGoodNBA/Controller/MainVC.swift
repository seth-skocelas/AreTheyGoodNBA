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
        
        asyncTestFunc()
        
        //2544 = Lebron
        //1628372 = DSJ
    
    }
    
    func asyncTestFunc() {
        
        let league = League()
        
        WebService.instance.leagueGroup.notify(queue: .main) {
            
            print("\(league.teams[0].teamName)")
            league.teams[0].getTeamRoster()
            
            WebService.instance.teamGroup.notify(queue: .main, execute: {
                
                print("\(league.teams[0].teamRoster[0].name): \(league.teams[0].teamRoster[0].playerID)")
                league.teams[0].teamRoster[0].getAllStats()
                
                WebService.instance.playerGroup.notify(queue: .main, execute: {
                    
                    print("Regular Season TS%: \(league.teams[0].teamRoster[0].currentRegularSeasonAdvStats.trueShooting)")
                    print("Career PTS: \(league.teams[0].teamRoster[0].careerRegularSeasonTradStats.points)")
                    
                })
            })
        }
    }




}

