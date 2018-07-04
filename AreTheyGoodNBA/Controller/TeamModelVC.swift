//
//  TeamModelVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/4/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit
import SVGKit

class TeamModelVC: UIViewController {
    
    var currentTeam: Team?
    var statDuration = StatDuration.CurrentSeason
    var model: TeamModel!
    var responseBuilder: TeamModelResponse!

    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var firstInfoLabel: UILabel!
    @IBOutlet weak var firstInfoValue: UILabel!
    @IBOutlet weak var secondInfoLabel: UILabel!
    @IBOutlet weak var secondInfoValue: UILabel!

    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var firstModelLine: UILabel!
    @IBOutlet weak var secondModelLine: UILabel!
    @IBOutlet weak var thirdModelLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebService.instance.teamGroup.notify(queue: .main) {
            
            self.setTeamInfo()
            self.setTeamImage()
            
            if let team = self.currentTeam {
                
                self.model = TeamModel(team: team, statDuration: self.statDuration)
                self.responseBuilder = TeamModelResponse(model: self.model)
                self.displayResult()
            }
            
        }
        
        /* this is temporary in order to export the players to a .CSV on the device. I might add a separate button for this on the home page in the future
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("CurrentPlayerStats.csv")
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        self.present(vc, animated: true, completion: nil)
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTeamStats" {
            
            if let destination = segue.destination as? TeamStatsVC {
                
                if let tuple = sender as? TeamStatsTuple {
                    
                    destination.teamStatsTuple = tuple
                    
                }
                
            }
            
        }
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func checkStatsPressed(_ sender: Any) {
        
        WebService.instance.teamGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "toTeamStats", sender: TeamStatsTuple(team: self.currentTeam!,statDuration: self.statDuration))
        }
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            statDuration = StatDuration.CurrentSeason
        } else if segment.selectedSegmentIndex == 1 {
            statDuration = StatDuration.Career
        }
        
        if let team = self.currentTeam {
            
            self.setTeamInfo()
            self.model = TeamModel(team: team, statDuration: self.statDuration)
            self.responseBuilder = TeamModelResponse(model: self.model)
            self.displayResult()
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
    
    func displayResult() {
        
        if self.model.result == Result.Yes {
            self.answerLabel.text = "Yes"
        } else if self.model.result == Result.No {
            self.answerLabel.text = "No"
        } else {
            self.answerLabel.text = "¯\\_(ツ)_/¯"
        }
        
        self.firstModelLine.text = responseBuilder.firstLine()
        self.secondModelLine.text = responseBuilder.secondLine()
        self.thirdModelLine.text = responseBuilder.thirdLine()
        
        
    }
    
}
