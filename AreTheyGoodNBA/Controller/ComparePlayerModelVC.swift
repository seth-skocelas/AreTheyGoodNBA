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
    var twoModel: PlayerModel!
    
    var responseBuilder: CompareModelResponse!
    
    @IBOutlet weak var firstModelLine: UILabel!
    @IBOutlet weak var secondModelLine: UILabel!
    @IBOutlet weak var thirdModelLine: UILabel!
    
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
            self.setClassTypeImages()
            //test code below
            
            if let playerOne = self.playerOne, let playerTwo = self.playerTwo {
                self.createModel(playerOne: playerOne, playerTwo: playerTwo)
                
                self.responseBuilder = CompareModelResponse(oneModel: self.oneModel, twoModel: self.twoModel)
                self.displayResult()
                
                if playerOne.modelPosition != playerTwo.modelPosition {
                    
                    let alert = UIAlertController(title: "Comparing Two Players of Different Positions", message: "Please note that model comparisons may not be as accurate since you are comparing two players of different positions. Please review the stats for yourself to make an educated decision.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }
                
                //self.model.exportStats(statDuration: StatDuration.CurrentSeason)
                
            }
            
        }
        
    }
    
    func setPlayerInfo() {
        
        if let oneText = playerOne?.name, let twoText = playerTwo?.name {
            
            if oneText == twoText {
                
                playerOneName.text = playerOne?.seasonFullName
                playerTwoName.text = playerTwo?.seasonFullName
                
            } else {
                
                playerOneName.text = oneText
                playerTwoName.text = twoText
                
            }
            
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
    
    func setClassTypeImages() {
        
        if let one = playerOne {
            self.playerOneImage.image = one.image.Image
            self.playerOneImage.isHidden = false
        }
        
        if let two = playerTwo {
            self.playerTwoImage.image = two.image.Image
            self.playerTwoImage.isHidden = false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toComparePlayerStats" {
            
            if let destination = segue.destination as? ComparePlayerStatsVC {
                
                destination.modalPresentationStyle = .fullScreen
        
                destination.playerOne = playerOne
                destination.playerTwo = playerTwo
                destination.statDuration = statDuration
                
            }
                
        }
        
        if segue.identifier == "toStartFromCompareModel" {
            
            if let destination = segue.destination as? MainVC {
                destination.modalPresentationStyle = .fullScreen
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
            self.responseBuilder = CompareModelResponse(oneModel: self.oneModel, twoModel: self.twoModel)
            //self.model.exportStats(statDuration: statDuration)
        }
        
        displayResult()
        
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
        
        if playerTwo.modelPosition == Position.Guard {
            self.twoModel = GuardModel(player: playerTwo, statDuration: self.statDuration, isSecondary: false)
        } else if playerTwo.modelPosition == Position.GuardForward {
            self.twoModel = GuardForwardModel(player: playerTwo, statDuration: self.statDuration, isSecondary: false)
        } else if playerTwo.modelPosition == Position.Forward {
            self.twoModel = ForwardModel(player: playerTwo, statDuration: self.statDuration, isSecondary: false)
        } else if playerTwo.modelPosition == Position.ForwardCenter {
            self.twoModel = ForwardCenterModel(player: playerTwo, statDuration: self.statDuration, isSecondary: false)
        } else if playerTwo.modelPosition == Position.Center {
            self.twoModel = CenterModel(player: playerTwo, statDuration: self.statDuration, isSecondary: false)
        }
        
        
    }
    
    func displayResult() {
        

        setPlayerName()
 
        self.firstModelLine.text = responseBuilder.firstLine()
        self.secondModelLine.text = responseBuilder.secondLine()
        self.thirdModelLine.text = responseBuilder.thirdLine()
        
        
        
    }
    
    func setPlayerName() {
        
        if let one = playerOne, let two = playerTwo {
            
            var oneName = ""
            var twoName = ""
            
            if one == two && one.selectedSeason != two.selectedSeason && statDuration == StatDuration.CurrentSeason {
                oneName = one.seasonFullName
                twoName = two.seasonFullName
            } else {
                oneName = one.name
                twoName = two.name
            }
            
            if (self.oneModel.statsScore - self.twoModel.statsScore) >= 0.05 {
                self.answerLabel.text = "\(oneName) > \(twoName)"
            } else if (self.oneModel.statsScore - self.twoModel.statsScore) <= -0.05 {
                self.answerLabel.text = "\(twoName) > \(oneName)"
            } else {
                self.answerLabel.text = "\(oneName) = \(twoName)"
            }
            
        }
        
    }
    

}
