//
//  ComparePlayerModel.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 11/12/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class ComparePlayerModelVC: UIViewController {
    
    var playerOne: Player?
    var playerTwo: Player?

    var statDuration = StatDuration.CurrentSeason
    
    var oneModel: PlayerModel!
    var oneOptionalModel: PlayerModel!
    var oneThirdModel: PlayerModel!
    
    var twoModel: PlayerModel!
    var twoOptionalModel: PlayerModel!
    var twoThirdModel: PlayerModel!
    
    var responseBuilder: PlayerModelResponse!
    
    @IBOutlet weak var firstModelLine: UILabel!
    @IBOutlet weak var secondModelLine: UILabel!
    @IBOutlet weak var thridModelLine: UILabel!
    
    @IBOutlet weak var playerOneImage: UIImageView!
    @IBOutlet weak var playerOneName: UILabel!
    @IBOutlet weak var oneYearsPlayed: UILabel!
    @IBOutlet weak var onePosition: UILabel!
    @IBOutlet weak var oneSeason: UILabel!
    
    @IBOutlet weak var playerTwoImage: UIImageView!
    @IBOutlet weak var playerTwoName: UILabel!
    @IBOutlet weak var twoYearsPlayed: UILabel!
    @IBOutlet weak var twoPosition: UILabel!
    @IBOutlet weak var twoSeason: UILabel!
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        WebService.instance.playerGroup.notify(queue: .main) {
            
            self.setPlayerInfo()
            self.setPlayerImage()
            //test code below
            
            if let playerOne = self.playerOne, let playerTwo = self.playerTwo {
                self.createModel(playerOne: playerOne, playerTwo: playerTwo)
                
                //self.responseBuilder = PlayerModelResponse(model: self.model)
                //self.displayResult()
                
                //self.model.exportStats(statDuration: StatDuration.CurrentSeason)
                
            }
            
        }
        
    }
    
    func setPlayerInfo() {
        
        if let text =  playerOne?.name {
            playerOneName.text = "\(text)"
        }
        
        if let text =  playerTwo?.name {
            playerTwoName.text = "\(text)"
        }
        
        if let text = playerOne?.selectedSeason {
            oneSeason.text = "\(text)"
        }
        
        if let text = playerTwo?.selectedSeason {
            twoSeason.text = "\(text)"
        }
        
        if let number =  playerOne?.yearsExperience {
            oneYearsPlayed.text = "\(number)"
        }
        
        if let number =  playerTwo?.yearsExperience {
            twoYearsPlayed.text = "\(number)"
        }
        
        if let text =  playerOne?.position {
            onePosition.text = text
        }
        
        if let text =  playerTwo?.position {
            twoPosition.text = text
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
                self.playerOneImage.image = UIImage(data: data!)
                self.playerOneImage.isHidden = false
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
                self.playerTwoImage.image = UIImage(data: data!)
                self.playerTwoImage.isHidden = false
            }
            }.resume()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toComparePlayerStats" {
            
            if let destination = segue.destination as? ComparePlayerStatsVC {
        
                destination.playerOne = playerOne
                destination.playerTwo = playerTwo
                destination.statDuration = statDuration
                
            }
                
        }
        
        if segue.identifier == "toStartFromCompareModel" {
            
            if let destination = segue.destination as? MainVC {
                destination.comparePlayer = nil
            }
            
        }
        
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            statDuration = StatDuration.CurrentSeason
        } else if segment.selectedSegmentIndex == 1 {
            statDuration = StatDuration.Career
        }
        
        if let playerOne = self.playerOne, let playerTwo = self.playerTwo {
            self.createModel(playerOne: playerOne, playerTwo: playerTwo)
            //self.responseBuilder = PlayerModelResponse(model: self.model)
            //self.model.exportStats(statDuration: statDuration)
        }
        
        //displayResult()
        
    }
    
    @IBAction func checkStatsPressed(_ sender: Any) {
        
        WebService.instance.playerGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "toComparePlayerStats", sender: nil)
        }
        
    }
    
    @IBAction func startOverPressed(_ sender: Any) {
        performSegue(withIdentifier: "toStartFromCompareModel", sender: nil)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func createModel(playerOne: Player, playerTwo: Player) {
        
        if playerOne.modelPosition == Position.Guard {
            self.oneModel = GuardModel(player: playerOne, statDuration: self.statDuration, isSecondary: false)
        } else if playerOne.modelPosition == Position.GuardForward {
            self.oneModel = GuardForwardModel(player: playerOne, statDuration: self.statDuration, isSecondary: false)
        } else if playerOne.modelPosition == Position.Forward {
            self.oneModel = ForwardModel(player: playerOne, statDuration: self.statDuration, isSecondary: false)
        } else if playerOne.modelPosition == Position.ForwardCenter {
            self.oneModel = ForwardCenterModel(player: playerOne, statDuration: self.statDuration, isSecondary: false)
        } else if playerOne.modelPosition == Position.Center {
            self.oneModel = CenterModel(player: playerOne, statDuration: self.statDuration, isSecondary: false)
        }
    }
    
    func displayResult() {
        
        
        /*
        if self.model.finalResult == Result.Yes {
            self.answerLabel.text = "Yes"
        } else if self.model.finalResult == Result.No {
            self.answerLabel.text = "No"
        } else {
            self.answerLabel.text = "¯\\_(ツ)_/¯"
        }
 
         */
        
        self.firstModelLine.text = responseBuilder.firstLine()
        self.secondModelLine.text = responseBuilder.secondLine()
        self.thridModelLine.text = responseBuilder.thirdLine()
        
        
    }
    

}
