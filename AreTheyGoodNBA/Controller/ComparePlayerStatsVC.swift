//
//  ComparePlayerStatsVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 11/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class ComparePlayerStatsVC: UIViewController {
    
    var playerOne: Player?
    var playerTwo: Player?
    var statDuration: StatDuration?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var measureTypeSegment: UISegmentedControl!
    @IBOutlet weak var oneStackView: UIStackView!
    @IBOutlet weak var twoStackView: UIStackView!
    @IBOutlet weak var oneErrorLabel: UILabel!
    @IBOutlet weak var twoErrorLabel: UILabel!
    @IBOutlet weak var onePlayerImage: UIImageView!
    @IBOutlet weak var twoPlayerImage: UIImageView!

    
    @IBOutlet var onePlayerName: UILabel!
    @IBOutlet weak var oneYearsPlayed: UILabel!
    @IBOutlet weak var onePosition: UILabel!
    
    @IBOutlet weak var oneGamesPlayed: UILabel!
    @IBOutlet weak var oneMinutesPlayed: UILabel!
    @IBOutlet weak var oneFieldGoalPercent: UILabel!
    @IBOutlet weak var oneThreePointPercent: UILabel!
    @IBOutlet weak var oneFieldGoalsMade: UILabel!
    @IBOutlet weak var oneThreePointsMade: UILabel!
    @IBOutlet weak var onePoints: UILabel!
    @IBOutlet weak var oneRebounds: UILabel!
    @IBOutlet weak var oneAssists: UILabel!
    @IBOutlet weak var oneTurnovers: UILabel!
    @IBOutlet weak var onePlusMinus: UILabel!
    @IBOutlet weak var oneOffRating: UILabel!
    @IBOutlet weak var oneDefRating: UILabel!
    @IBOutlet weak var oneTrueShooting: UILabel!
    @IBOutlet weak var onePlusMinusLabel: UILabel!
    @IBOutlet weak var oneNetRating: UILabel!
    @IBOutlet weak var oneUsage: UILabel!
    
    @IBOutlet var twoPlayerName: UILabel!
    @IBOutlet weak var twoYearsPlayed: UILabel!
    @IBOutlet weak var twoPosition: UILabel!
    
    @IBOutlet weak var twoGamesPlayed: UILabel!
    @IBOutlet weak var twoMinutesPlayed: UILabel!
    @IBOutlet weak var twoFieldGoalPercent: UILabel!
    @IBOutlet weak var twoThreePointPercent: UILabel!
    @IBOutlet weak var twoFieldGoalsMade: UILabel!
    @IBOutlet weak var twoThreePointsMade: UILabel!
    @IBOutlet weak var twoPoints: UILabel!
    @IBOutlet weak var twoRebounds: UILabel!
    @IBOutlet weak var twoAssists: UILabel!
    @IBOutlet weak var twoTurnovers: UILabel!
    @IBOutlet weak var twoPlusMinus: UILabel!
    @IBOutlet weak var twoOffRating: UILabel!
    @IBOutlet weak var twoDefRating: UILabel!
    @IBOutlet weak var twoTrueShooting: UILabel!
    @IBOutlet weak var twoPlusMinusLabel: UILabel!
    @IBOutlet weak var twoNetRating: UILabel!
    @IBOutlet weak var twoUsage: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
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
        
        if let text =  playerOne?.name {
            onePlayerName.text = text
        }
        
        if let number =  playerOne?.yearsExperience {
            oneYearsPlayed.text = "\(number)"
        }
        
        if let text =  playerOne?.position {
            onePosition.text = text
        }
        
        if let text =  playerTwo?.name {
            twoPlayerName.text = text
        }
        
        if let number =  playerTwo?.yearsExperience {
            twoYearsPlayed.text = "\(number)"
        }
        
        if let text =  playerTwo?.position {
            twoPosition.text = text
        }
        
        
    }
    
    func setPlayerStats() {
        
        var oneTradStats: TradStats!
        var oneAdvStats: AdvStats!
        var twoTradStats: TradStats!
        var twoAdvStats: AdvStats!
        
        if statDuration == StatDuration.CurrentSeason {
            
            if measureTypeSegment.selectedSegmentIndex == 0 {
                
                oneTradStats = (playerOne?.currentRegularSeasonTradStats)!
                oneAdvStats = (playerOne?.currentRegularSeasonAdvStats)!
                
                twoTradStats = (playerTwo?.currentRegularSeasonTradStats)!
                twoAdvStats = (playerTwo?.currentRegularSeasonAdvStats)!
                
            } else if measureTypeSegment.selectedSegmentIndex == 1 {
                
                oneTradStats = (playerOne?.currentPostSeasonTradStats)!
                oneAdvStats = (playerOne?.currentPostSeasonAdvStats)!
                
                twoTradStats = (playerOne?.currentPostSeasonTradStats)!
                twoAdvStats = (playerOne?.currentPostSeasonAdvStats)!
                
            }
            
        } else if statDuration == StatDuration.Career {
            
            if measureTypeSegment.selectedSegmentIndex == 0 {
                
                oneTradStats = (playerOne?.careerRegularSeasonTradStats)!
                oneAdvStats = (playerOne?.careerRegularSeasonAdvStats)!
                
                twoTradStats = (playerOne?.careerRegularSeasonTradStats)!
                twoAdvStats = (playerOne?.careerRegularSeasonAdvStats)!
                
            } else if measureTypeSegment.selectedSegmentIndex == 1 {
                
                oneTradStats = (playerOne?.careerPostSeasonTradStats)!
                oneAdvStats = (playerOne?.careerPostSeasonAdvStats)!
                
                twoTradStats = (playerOne?.careerPostSeasonTradStats)!
                twoAdvStats = (playerOne?.careerPostSeasonAdvStats)!
                
            }
            
        }
        
        if !(oneTradStats.isEmpty) || !(oneAdvStats.isEmpty)  {
            
            //oneErrorLabel.isHidden = true
            
            oneGamesPlayed.text = "\(oneTradStats.gamesPlayed)"
            oneMinutesPlayed.text = "\(oneTradStats.minutesPlayed.oneDecimalString)"
            oneThreePointPercent.text = "\(oneTradStats.threePointPercent.threeDecimalString)"
            oneFieldGoalPercent.text = "\(oneTradStats.fieldGoalPercent.threeDecimalString)"
            oneFieldGoalsMade.text = "\(oneTradStats.fieldGoalPerMin.oneDecimalString)"
            oneThreePointsMade.text = "\(oneTradStats.threePointPerMin.oneDecimalString)"
            onePoints.text = "\(oneTradStats.points.oneDecimalString)"
            oneRebounds.text = "\(oneTradStats.rebounds.oneDecimalString)"
            oneAssists.text = "\(oneTradStats.assists.oneDecimalString)"
            oneTurnovers.text = "\(oneTradStats.turnovers.oneDecimalString)"
            
            if statDuration == StatDuration.CurrentSeason {
                onePlusMinus.isHidden = false
                onePlusMinusLabel.isHidden = false
                onePlusMinus.text = "\(oneTradStats.plusMinus.oneDecimalString)"
            } else {
                onePlusMinus.isHidden = true
                onePlusMinusLabel.isHidden = true
            }
            
            oneOffRating.text = "\(oneAdvStats.offRating.oneDecimalString)"
            oneDefRating.text = "\(oneAdvStats.defRating.oneDecimalString)"
            oneNetRating.text = "\(oneAdvStats.netRating.oneDecimalString)"
            oneUsage.text = "\(oneAdvStats.usage.threeDecimalString)"
            oneTrueShooting.text = "\(oneAdvStats.trueShooting.threeDecimalString)"
            
            oneStackView.isHidden = false
            
        } else {
            oneStackView.isHidden = true
            //oneErrorLabel.isHidden = false
        }
        
        if !(twoTradStats.isEmpty) || !(twoAdvStats.isEmpty)  {
            
            //twoErrorLabel.isHidden = true
            
            twoGamesPlayed.text = "\(twoTradStats.gamesPlayed)"
            twoMinutesPlayed.text = "\(twoTradStats.minutesPlayed.oneDecimalString)"
            twoThreePointPercent.text = "\(twoTradStats.threePointPercent.threeDecimalString)"
            twoFieldGoalPercent.text = "\(twoTradStats.fieldGoalPercent.threeDecimalString)"
            twoFieldGoalsMade.text = "\(twoTradStats.fieldGoalPerMin.oneDecimalString)"
            twoThreePointsMade.text = "\(twoTradStats.threePointPerMin.oneDecimalString)"
            twoPoints.text = "\(twoTradStats.points.oneDecimalString)"
            twoRebounds.text = "\(twoTradStats.rebounds.oneDecimalString)"
            twoAssists.text = "\(twoTradStats.assists.oneDecimalString)"
            twoTurnovers.text = "\(twoTradStats.turnovers.oneDecimalString)"
            
            if statDuration == StatDuration.CurrentSeason {
                twoPlusMinus.isHidden = false
                twoPlusMinusLabel.isHidden = false
                twoPlusMinus.text = "\(twoTradStats.plusMinus.oneDecimalString)"
            } else {
                twoPlusMinus.isHidden = true
                twoPlusMinusLabel.isHidden = true
            }
            
            twoOffRating.text = "\(twoAdvStats.offRating.oneDecimalString)"
            twoDefRating.text = "\(twoAdvStats.defRating.oneDecimalString)"
            twoNetRating.text = "\(twoAdvStats.netRating.oneDecimalString)"
            twoUsage.text = "\(twoAdvStats.usage.threeDecimalString)"
            twoTrueShooting.text = "\(twoAdvStats.trueShooting.threeDecimalString)"
            
            twoStackView.isHidden = false
            
        } else {
            twoStackView.isHidden = true
            //twoErrorLabel.isHidden = false
        }
        
    }
    
    func setPlayerImage() {
        
        var urlString = ""
        
        if let teamID = playerOne?.teamID {
            urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            if let playerID = playerOne?.playerID {
                urlString = "\(urlString)\(playerID).png"
            }
        }
        
        
        guard let urlOne = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: urlOne) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.onePlayerImage.image = UIImage(data: data!)
                self.onePlayerImage.isHidden = false
            }
            }.resume()
        
        if let teamID = playerTwo?.teamID {
            urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            if let playerID = playerTwo?.playerID {
                urlString = "\(urlString)\(playerID).png"
            }
        }
        
        
        guard let urlTwo = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: urlTwo) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.twoPlayerImage.image = UIImage(data: data!)
                self.twoPlayerImage.isHidden = false
            }
            }.resume()
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        setPlayerStats()
        
    }
    

}
