//
//  PlayerModelVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 4/4/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class PlayerModelVC: UIViewController {
    
    var currentPlayer: Player?
    var statDuration = StatDuration.CurrentSeason
    var model: PlayerModel!
    var optionalModel: PlayerModel!
    var thirdModel: PlayerModel!
    var responseBuilder: PlayerModelResponse!

    @IBOutlet weak var firstModelLine: UILabel!
    @IBOutlet weak var secondModelLine: UILabel!
    @IBOutlet weak var thridModelLine: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var startYear: UILabel!
    @IBOutlet weak var yearsPlayed: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var jerseyNumber: UILabel!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        WebService.instance.playerGroup.notify(queue: .main) {
            
            self.setPlayerInfo()
            self.setPlayerImage()
            //test code below
            
            if let player = self.currentPlayer {
                self.createModel(player: player)
                self.responseBuilder = PlayerModelResponse(model: self.model)
                self.segment.setTitle("\(player.selectedSeason)", forSegmentAt: 0)
                self.displayResult()
                
                //self.model.exportStats(statDuration: StatDuration.CurrentSeason)
                
            }
            
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
    
    func setPlayerImage() {
        
        var urlString = ""
        
        if let teamID = currentPlayer?.teamID {
            urlString = "\(BASE_PICTURE_URL)\(teamID)\(PICTURE_INFO_URL)"
            if let playerID = currentPlayer?.playerID {
                urlString = "\(urlString)\(playerID).png"
            }
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
                self.playerImage.image = UIImage(data: data!)
                self.playerImage.isHidden = false
            }
            }.resume()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlayerStats" {
            
            if let destination = segue.destination as? PlayerStatsVC {
                
                if let tuple = sender as? PlayerStatsTuple {
                    
                    destination.playerStatsTuple = tuple
                    
                }
                
            }
            
        }
        
        if segue.identifier == "toSelectFromModel" {
            if let destination = segue.destination as? MainVC {
                    destination.comparePlayer = currentPlayer
                }
            }
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            statDuration = StatDuration.CurrentSeason
        } else if segment.selectedSegmentIndex == 1 {
            statDuration = StatDuration.Career
        }
        
        if let player = self.currentPlayer {
            self.createModel(player: player)
            self.responseBuilder = PlayerModelResponse(model: self.model)
            //self.model.exportStats(statDuration: statDuration)
        }
        
        displayResult()
        
    }
    
    @IBAction func checkStatsPressed(_ sender: Any) {
        
        WebService.instance.playerGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "toPlayerStats", sender: PlayerStatsTuple(player: self.currentPlayer!,statDuration: self.statDuration))
        }
        
    }
    
    @IBAction func comparePressed(_ sender: Any) {
    
        self.performSegue(withIdentifier: "toSelectFromModel", sender: nil)
        
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func createModel(player: Player) {
        
        if player.modelPosition == Position.Guard {
            self.model = GuardModel(player: player, statDuration: self.statDuration, isSecondary: false)
        } else if player.modelPosition == Position.GuardForward {
            self.model = GuardForwardModel(player: player, statDuration: self.statDuration, isSecondary: false)
        } else if player.modelPosition == Position.Forward {
            self.model = ForwardModel(player: player, statDuration: self.statDuration, isSecondary: false)
        } else if player.modelPosition == Position.ForwardCenter {
            self.model = ForwardCenterModel(player: player, statDuration: self.statDuration, isSecondary: false)
        } else if player.modelPosition == Position.Center {
            self.model = CenterModel(player: player, statDuration: self.statDuration, isSecondary: false)
        }
    }
    
    func displayResult() {
        
        if self.model.finalResult == Result.Yes {
            self.answerLabel.text = "Yes"
        } else if self.model.finalResult == Result.No {
            self.answerLabel.text = "No"
        } else {
            self.answerLabel.text = "¯\\_(ツ)_/¯"
        }
        
        self.firstModelLine.text = responseBuilder.firstLine()
        self.secondModelLine.text = responseBuilder.secondLine()
        self.thridModelLine.text = responseBuilder.thirdLine()
        
        
    }
    

    
}
