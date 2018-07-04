//
//  TeamStatsVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/1/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit
import SVGKit

class TeamStatsVC: UIViewController {
    
    var currentTeam: Team?
    var statDuration: StatDuration?
    var teamStatsTuple: TeamStatsTuple?

    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var firstInfoLabel: UILabel!
    @IBOutlet weak var firstInfoValue: UILabel!
    @IBOutlet weak var secondInfoLabel: UILabel!
    @IBOutlet weak var secondInfoValue: UILabel!
    
    @IBOutlet weak var measureTypeSegment: UISegmentedControl!
    
    @IBOutlet weak var regularSeasonStackView: UIStackView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var franchiseStackView: UIStackView!
    
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
    @IBOutlet weak var effectiveFG: UILabel!
    @IBOutlet weak var trueShooting: UILabel!
    @IBOutlet weak var pace: UILabel!
    @IBOutlet weak var pie: UILabel!
    
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var losses: UILabel!
    @IBOutlet weak var winPercentage: UILabel!
    @IBOutlet weak var playoffApperances: UILabel!
    @IBOutlet weak var divisionTitles: UILabel!
    @IBOutlet weak var conferenceTitles: UILabel!
    @IBOutlet weak var leagueTitles: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTeam = teamStatsTuple?.team
        statDuration = teamStatsTuple?.statDuration

        WebService.instance.teamGroup.notify(queue: .main) {
            
            self.setTeamInfo()
            self.setTeamImage()
            
            if self.statDuration == StatDuration.CurrentSeason {
                
                self.setTeamSeasonStats()
                
            } else if self.statDuration == StatDuration.Career {
                
                self.setTeamCareerStats()
                
            }
            
        }
        
        /* this is temporary in order to export the players to a .CSV on the device. I might add a separate button for this on the home page in the future
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("CareerPlayerStats.csv")
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        */
    }


    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        setTeamInfo()
        setTeamSeasonStats()
    }
    
    func setTeamInfo() {
        
        if let text = currentTeam?.teamName {
            teamName.text = text
        }
        
        if statDuration == StatDuration.Career {
            
            if let text = currentTeam?.startYear {
                firstInfoLabel.text = "Start Year:"
                firstInfoValue.text = text
            }
            
            if let number = currentTeam?.gamesPlayed {
                secondInfoLabel.text = "Games Played:"
                secondInfoValue.text = "\(number)"
            }
            
        } else {
            
            if let wins = currentTeam?.currentWins, let losses = currentTeam?.currentLosses {
                firstInfoLabel.text = "Win/Loss:"
                firstInfoValue.text = "\(wins)-\(losses)"
            }
            
            if let number = currentTeam?.currentRegularSeasonAdvStats.netRating {
                secondInfoLabel.text = "Net Rating:"
                secondInfoValue.text = number.oneDecimalString
            }
            
        }
        
    }
    
    func setTeamSeasonStats() {
        
        self.franchiseStackView.isHidden = true
        self.measureTypeSegment.isHidden = false
        self.regularSeasonStackView.isHidden = false
        
        var tradStats: TradStats!
        var advStats: AdvStats!
        
        if measureTypeSegment.selectedSegmentIndex == 0 {
            
            tradStats = (currentTeam?.currentRegularSeasonTradStats)!
            advStats = (currentTeam?.currentRegularSeasonAdvStats)!
            
        } else if measureTypeSegment.selectedSegmentIndex == 1 {
            
            tradStats = (currentTeam?.currentPostSeasonTradStats)!
            advStats = (currentTeam?.currentPostSeasonAdvStats)!
            
        }
        
        if !(tradStats.isEmpty) || !(advStats.isEmpty)  {
            
            errorLabel.isHidden = true
            
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
            effectiveFG.text = "\(advStats.effectiveFG.threeDecimalString)"
            trueShooting.text = "\(advStats.trueShooting.threeDecimalString)"
            pace.text = "\(advStats.pace.threeDecimalString)"
            pie.text = "\(advStats.PIE.threeDecimalString)"
            
            regularSeasonStackView.isHidden = false
            
        } else {
            regularSeasonStackView.isHidden = true
            errorLabel.isHidden = false
        }
    }
    
    func setTeamCareerStats() {
        
        self.measureTypeSegment.isHidden = true
        self.regularSeasonStackView.isHidden = true
        self.franchiseStackView.isHidden = false
        
        if let team = currentTeam {
        
            wins.text = "\(team.wins)"
            losses.text = "\(team.losses)"
            winPercentage.text = "\(team.winPercentage)"
            playoffApperances.text = "\(team.playoffApperances)"
            divisionTitles.text = "\(team.divisionTitles)"
            conferenceTitles.text = "\(team.conferenceTitles)"
            leagueTitles.text = "\(team.leagueTitles)"
            
        }
        
    }
    
    
    func setTeamImage() {
        
        var urlString = ""
        
        if let team = currentTeam {
            urlString = "\(BASE_LOGO_URL)\(team.teamAbbreviation)\(LOGO_INFO_URL)"
        }
        
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
                let svgImage = SVGKImage(data: data!)
                self.teamLogo.image = svgImage?.uiImage
                self.teamLogo.isHidden = false
            }
            }.resume()
        
        
    }
    

}
