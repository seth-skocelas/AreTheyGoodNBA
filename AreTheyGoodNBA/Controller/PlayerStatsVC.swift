//
//  PlayerStatsVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/1/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class PlayerStatsVC: UIViewController {
    
    var currentPlayer: Player?
    var playerStatsTuple: PlayerStatsTuple?
    var statDuration: StatDuration?
    
    @IBOutlet weak var measureTypeSegment: UISegmentedControl!
    @IBOutlet weak var statsStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var playerName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var yearsPlayed: UILabel!
    @IBOutlet weak var jerseyNumber: UILabel!
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var gamesPlayed: UILabel!
    @IBOutlet weak var minutesPlayed: UILabel!
    @IBOutlet weak var fieldGoalPercent: UILabel!
    @IBOutlet weak var threePointPercent: UILabel!
    @IBOutlet weak var fieldGoalsMade: UILabel!
    @IBOutlet weak var threePointsMade: UILabel!
    @IBOutlet weak var fieldGoalAttempts: UILabel!
    @IBOutlet weak var threePointAttempts: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rebounds: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var turnovers: UILabel!
    @IBOutlet weak var plusMinus: UILabel!
    @IBOutlet weak var plusMinusLabel: UILabel!
    
    @IBOutlet weak var offRating: UILabel!
    @IBOutlet weak var defRating: UILabel!
    @IBOutlet weak var netRating: UILabel!
    @IBOutlet weak var usage: UILabel!
    @IBOutlet weak var effectiveFG: UILabel!
    @IBOutlet weak var trueShooting: UILabel!
    @IBOutlet weak var pace: UILabel!
    @IBOutlet weak var pie: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currentPlayer = playerStatsTuple?.player
        statDuration = playerStatsTuple?.statDuration
        
        if statDuration == StatDuration.CurrentSeason {
            titleLabel.text = "Current Season Stats"
        } else if statDuration == StatDuration.Career {
            titleLabel.text = "Career Stats"
        }
        
        WebService.instance.playerGroup.notify(queue: .main) {
            self.setPlayerInfo()
            self.setPlayerStats()
            self.setPlayerImage()
        }
        
    }
    
    
    
    func setPlayerInfo() {
        
        if let text =  currentPlayer?.name {
            playerName.text = text
        }
        
        if let text =  currentPlayer?.startingYear {
            startYear.text = text
        }
        
        if let number =  currentPlayer?.yearsExperience {
            yearsPlayed.text = "\(number)"
        }
        
        if let text =  currentPlayer?.jerseyNumber {
            jerseyNumber.text = text
        }
        
        if let text =  currentPlayer?.position {
            position.text = text
        }
        
        
    }
    
    func setPlayerStats() {
        
        var tradStats: TradStats!
        var advStats: AdvStats!
        
        if statDuration == StatDuration.CurrentSeason {
        
            if measureTypeSegment.selectedSegmentIndex == 0 {
                
                tradStats = (currentPlayer?.currentRegularSeasonTradStats)!
                advStats = (currentPlayer?.currentRegularSeasonAdvStats)!
                
            } else if measureTypeSegment.selectedSegmentIndex == 1 {
                
                tradStats = (currentPlayer?.currentPostSeasonTradStats)!
                advStats = (currentPlayer?.currentPostSeasonAdvStats)!
                
            }
            
        } else if statDuration == StatDuration.Career {
            
            if measureTypeSegment.selectedSegmentIndex == 0 {
                
                tradStats = (currentPlayer?.careerRegularSeasonTradStats)!
                advStats = (currentPlayer?.careerRegularSeasonAdvStats)!
                
            } else if measureTypeSegment.selectedSegmentIndex == 1 {
                
                tradStats = (currentPlayer?.careerPostSeasonTradStats)!
                advStats = (currentPlayer?.careerPostSeasonAdvStats)!
                
            }
            
        }
        
        if !(tradStats.isEmpty) || !(advStats.isEmpty)  {
            
            errorLabel.isHidden = true
        
            gamesPlayed.text = "\(tradStats.gamesPlayed)"
            minutesPlayed.text = "\(tradStats.minutesPlayed)"
            threePointPercent.text = "\(tradStats.threePointPercent)"
            fieldGoalPercent.text = "\(tradStats.fieldGoalPercent)"
            fieldGoalsMade.text = "\(tradStats.fieldGoalPerMin)"
            threePointsMade.text = "\(tradStats.threePointPerMin)"
            fieldGoalAttempts.text = "\(tradStats.fieldGoalAttempts)"
            threePointAttempts.text = "\(tradStats.threePointAttempts)"
            points.text = "\(tradStats.points)"
            rebounds.text = "\(tradStats.rebounds)"
            assists.text = "\(tradStats.assists)"
            turnovers.text = "\(tradStats.turnovers)"
            
            if statDuration == StatDuration.CurrentSeason {
                plusMinus.isHidden = false
                plusMinusLabel.isHidden = false
                plusMinus.text = "\(tradStats.plusMinus)"
            } else {
                plusMinus.isHidden = true
                plusMinusLabel.isHidden = true
            }
            
            offRating.text = "\(advStats.offRating)"
            defRating.text = "\(advStats.defRating)"
            netRating.text = "\(advStats.netRating)"
            usage.text = "\(advStats.usage)"
            effectiveFG.text = "\(advStats.effectiveFG)"
            trueShooting.text = "\(advStats.trueShooting)"
            pace.text = "\(advStats.pace)"
            pie.text = "\(advStats.PIE)"
            
            statsStackView.isHidden = false
        
        } else {
            statsStackView.isHidden = true
            errorLabel.isHidden = false
        }
        
    }
    
    func setPlayerImage() {
        
        var urlString = ""
        
        if let teamID = currentPlayer?.teamID {
            urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            if let playerID = currentPlayer?.playerID {
                urlString = "\(urlString)\(playerID).png"
            }
        }
        
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.playerImage.image = UIImage(data: data!)
                self.playerImage.isHidden = false
            }
            }.resume()
        
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        setPlayerStats()
        
    }
}
