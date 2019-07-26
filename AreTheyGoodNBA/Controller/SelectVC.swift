//
//  SelectVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 3/7/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class SelectVC: UIViewController {
    
    var league: League!
    var selectedSeason: String?
    var selectedTeam = Team()
    var selectedPlayer = Player()
    var currentPlayerIndex = 0
    var comparePlayer: Player?
    var compareMode = false;
    
    @IBOutlet weak var teamPicker: UIPickerView!
    @IBOutlet weak var playerPicker: UIPickerView!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var seasonLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if selectedSeason != nil {
            seasonLabel.text = selectedSeason
        }
        
        teamPicker.delegate = self
        teamPicker.dataSource = self
        
        playerPicker.delegate = self
        playerPicker.dataSource = self
        
        //createPlayerStatsCSV()
        
        createLeague()
        
        if let player = comparePlayer {
            teamButton.isHidden = true
            compareMode = true
            print("SelectVC: \(player.name)")
        }
        
        //2544 = Lebron
        //1628372 = DSJ
    
    }
    
    func createLeague() {
        
        if let season = selectedSeason {
            league = League(selectedSeason: season)
        } else {
            league = League(selectedSeason: "")
        }
        
        WebService.instance.leagueGroup.notify(queue: .main) {
            
            if self.league.teams.count != 0 {
                
                self.league.adjustTeamListBySeason(seasonString: self.selectedSeason!)
                
                self.teamPicker.reloadAllComponents()
                
                self.league.loadTeamStandings()
                
                
                self.selectedTeam = self.league.teams[0]
                self.league.teams[0].getTeamRoster()
                self.teamButton.isEnabled = true
            
                WebService.instance.teamGroup.notify(queue: .main) {
                
                    if self.selectedTeam.teamRoster.count != 0 {
                        
                        self.playerPicker.reloadAllComponents()
                        self.playerButton.isEnabled = true
                        
                        self.selectedPlayer = self.selectedTeam.teamRoster[0]
                        
                    } else {
                        
                        let alert = UIAlertController(title: "Unable to Load Players", message: "Unable to proceed. Please verify that you are connected to the internet.", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                        
                    }
            
                }
                
            } else {
                
                let alert = UIAlertController(title: "Unable to Load Teams", message: "Unable to proceed. Please verify that you are connected to the internet.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTeamModel" {
            
            if let destination = segue.destination as? TeamModelVC {
                
                destination.modalPresentationStyle = .fullScreen
                
                if let team = sender as? Team {
                    
                    destination.currentTeam = team
                }
                
            }
            
        }
        
        if segue.identifier == "toPlayerModel" {
            
            if let destination = segue.destination as? PlayerModelVC {
                
                destination.modalPresentationStyle = .fullScreen
                
                if let player = sender as? Player {
                    
                    destination.currentPlayer = player
                    
                }
                
            }
            
        }
        
        if segue.identifier == "toComparePlayerModel" {
            
            if let destination = segue.destination as? ComparePlayerModelVC {
                
                destination.modalPresentationStyle = .fullScreen
                destination.playerOne = comparePlayer
                destination.playerTwo = selectedPlayer
                
            }
            
        }
        
    }
    
    func createPlayerStatsCSV() {
        
        let currentFileName = "CurrentPlayerStats.csv"
        let currentPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(currentFileName)
        
        let careerFileName = "CareerPlayerStats.csv"
        let careerPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(careerFileName)
        
        let header = "ID,Player Name,Team,Years,Position,GamesPlayed,MinutesPlayed,3PT%,3PTM,3PTA,FG%,FGM,FGA,PTS,REB,AST,TO,+/-,OffRating,DefRating,NetRating,EFG%,TS%,USG,PACE,PIE,Inconclusive,Score\n"
        
        do {
            try header.write(to: currentPath!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        do {
            try header.write(to: careerPath!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
    }
    
    @IBAction func analyzeTeamPressed(_ sender: Any) {
        
        teamButton.isEnabled = false
        playerButton.isEnabled = false
        selectedTeam.getAllStats()
        WebService.instance.teamGroup.notify(queue: .main) {
            self.performSegue(withIdentifier: "toTeamModel", sender: self.selectedTeam)
            self.teamButton.isEnabled = true
            self.playerButton.isEnabled = true
        }
        
    }
    

    @IBAction func analyzePlayerPressed(_ sender: Any) {
        
        playerButton.isEnabled = false
        teamButton.isEnabled = false
        selectedPlayer.getAllStats()
        
        if (compareMode) {
            
            WebService.instance.playerGroup.notify(queue: .main) {
                self.performSegue(withIdentifier: "toComparePlayerModel", sender: nil)
                self.playerButton.isEnabled = true
                self.teamButton.isEnabled = true
                self.teamButton.isHidden = false
            }
            
        } else {
            
            WebService.instance.playerGroup.notify(queue: .main) {
                self.performSegue(withIdentifier: "toPlayerModel", sender: self.selectedPlayer)
                self.playerButton.isEnabled = true
                self.teamButton.isEnabled = true
                
            }
        }
        
    }
    
    @IBAction func seasonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SelectVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString = NSAttributedString()
        
        if pickerView.tag == 1 {
            
            let team = league.teams[row]
            attributedString = NSAttributedString(string: team.teamName, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            
        } else if pickerView.tag == 2 {
            
            let player = selectedTeam.teamRoster[row]
            attributedString = NSAttributedString(string: player.name, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        }
        
        return attributedString
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return league.teams.count
        }
        
        else if pickerView.tag == 2 {

            return selectedTeam.teamRoster.count

        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            
            selectedTeam = league.teams[row]
            selectedTeam.getTeamRoster()
            
            WebService.instance.teamGroup.notify(queue: .main) {
                
                if self.selectedTeam.teamRoster.count != 0 {
                    
                    self.selectedPlayer = self.selectedTeam.teamRoster[0]
                    self.playerPicker.reloadAllComponents()
                    self.playerPicker.selectRow(0, inComponent: 0, animated: true)
                    
                }
                
            }
            
        }
        
        if pickerView.tag == 2 {
            
            currentPlayerIndex = row
            
            if selectedTeam.teamRoster.count != 0 {
                selectedPlayer = selectedTeam.teamRoster[row]
            }
            
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}

    


