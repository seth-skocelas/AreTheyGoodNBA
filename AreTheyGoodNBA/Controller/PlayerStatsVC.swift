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
        
        //self.measureTypeSegment.setTitle("Test", forSegmentAt: 0)
        //self.measureTypeSegment.setTitle("Test", forSegmentAt: 1)

        
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
            self.setClassTypeImage()
            
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
            minutesPlayed.text = "\(tradStats.minutesPlayed.oneDecimalString)"
            threePointPercent.text = "\(tradStats.threePointPercent.threeDecimalString)"
            fieldGoalPercent.text = "\(tradStats.fieldGoalPercent.threeDecimalString)"
            fieldGoalsMade.text = "\(tradStats.fieldGoalPerMin.threeDecimalString)"
            threePointsMade.text = "\(tradStats.threePointPerMin.oneDecimalString)"
            fieldGoalAttempts.text = "\(tradStats.fieldGoalAttempts.oneDecimalString)"
            threePointAttempts.text = "\(tradStats.threePointAttempts.oneDecimalString)"
            points.text = "\(tradStats.points.oneDecimalString)"
            rebounds.text = "\(tradStats.rebounds.oneDecimalString)"
            assists.text = "\(tradStats.assists.oneDecimalString)"
            turnovers.text = "\(tradStats.turnovers.oneDecimalString)"
            
            if statDuration == StatDuration.CurrentSeason {
                plusMinus.isHidden = false
                plusMinusLabel.isHidden = false
                plusMinus.text = "\(tradStats.plusMinus.oneDecimalString)"
            } else {
                plusMinus.isHidden = true
                plusMinusLabel.isHidden = true
            }
            
            offRating.text = "\(advStats.offRating.oneDecimalString)"
            defRating.text = "\(advStats.defRating.oneDecimalString)"
            netRating.text = "\(advStats.netRating.oneDecimalString)"
            usage.text = "\(advStats.usage.threeDecimalString)"
            effectiveFG.text = "\(advStats.effectiveFG.threeDecimalString)"
            trueShooting.text = "\(advStats.trueShooting.threeDecimalString)"
            pace.text = "\(advStats.pace.threeDecimalString)"
            pie.text = "\(advStats.PIE.threeDecimalString)"
            
            statsStackView.isHidden = false
        
        } else {
            statsStackView.isHidden = true
            errorLabel.isHidden = false
        }
        
    }
    
    func setClassTypeImage() {
        
        if let player = currentPlayer {
            self.playerImage.image = player.image.Image
            self.playerImage.isHidden = false
        }
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        setPlayerStats()
        
    }
    
    @IBAction func comparePressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toSelectFromStats", sender: currentPlayer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSelectFromStats" {
            if let destination = segue.destination as? MainVC {
                destination.modalPresentationStyle = .fullScreen
                destination.comparePlayer = currentPlayer
            }
        }
        
    }
    
}
