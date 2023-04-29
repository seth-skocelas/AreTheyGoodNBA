//
//  MainVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 8/17/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var leaguePicker: UIPickerView!
    @IBOutlet weak var seasonPicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedSeason = SEASON_YEAR_CURRENT
    var comparePlayer: Player?
    var currentSeasonArray = seasonSelectArray
    var currentLeague = WebService.instance.currentLeague
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        leaguePicker.dataSource = self
        leaguePicker.delegate = self
        
        WebService.instance.SELECTED_SEASON = "Season=\(seasonSelectArray[0])&"
        selectedSeason = seasonSelectArray[0]
        self.seasonPicker.reloadAllComponents()
        
        if let player = comparePlayer {
            
            print(player.name)
            startButton.setTitle("Back", for: .normal)
            titleLabel.text = "Compare \(player.name) to:"
            
            if player.leagueName == LeagueName.WNBA
            {
                leaguePicker.selectRow(1, inComponent: 0, animated: true)
            }
            else
            {
                leaguePicker.selectRow(0, inComponent: 0, animated: true)
            }
            
            leaguePicker.isUserInteractionEnabled = false
            leaguePicker.alpha = 0.5
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSelect" {
            if let destination = segue.destination as? SelectVC {
                
                destination.modalPresentationStyle = .fullScreen
                
                if let season = sender as? String {
                    destination.selectedSeason = season
                }
                
                if let player = comparePlayer {
                    destination.comparePlayer = player
                }
            }
        }
        
        
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        if comparePlayer != nil {
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "toAppInfo", sender: nil)
        }
        
    }
    
    @IBAction func selectPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toSelect", sender: selectedSeason)
        
    }
    
}


extension MainVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString = NSAttributedString()
        
        if pickerView.tag == 0 {
            attributedString = NSAttributedString(string: leagueSelectArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        }
        
        if pickerView.tag == 1 {
            if currentLeague == LeagueName.WNBA {
                attributedString = NSAttributedString(string: seasonWNBASelectArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            } else {
                attributedString = NSAttributedString(string: seasonSelectArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            }
        }
        
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return leagueSelectArray.count
        }
        if pickerView.tag == 1 {
            if currentLeague == LeagueName.WNBA {
                return seasonWNBASelectArray.count
            }
            return seasonSelectArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            
            if row == 0 {
                WebService.instance.SELECTED_LEAGUE = "LeagueID=00&"
                WebService.instance.currentLeague = LeagueName.NBA
                currentLeague = LeagueName.NBA
                WebService.instance.SELECTED_SEASON = "Season=\(seasonSelectArray[0])&"
                selectedSeason = seasonSelectArray[0]
                self.seasonPicker.reloadAllComponents()
            }
            if row == 1 {
                WebService.instance.SELECTED_LEAGUE = "LeagueID=10&"
                WebService.instance.currentLeague = LeagueName.WNBA
                currentLeague = LeagueName.WNBA
                WebService.instance.SELECTED_SEASON = "Season=\(seasonWNBASelectArray[0])&"
                selectedSeason = seasonWNBASelectArray[0]
                self.seasonPicker.reloadAllComponents()
            }
            
        }
        
        if pickerView.tag == 1 {
            
            if currentLeague == LeagueName.WNBA {
                WebService.instance.SELECTED_SEASON = "Season=\(seasonWNBASelectArray[row])&"
                selectedSeason = seasonWNBASelectArray[row]
            } else {
                WebService.instance.SELECTED_SEASON = "Season=\(seasonSelectArray[row])&"
                selectedSeason = seasonSelectArray[row]
            }
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
