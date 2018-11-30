//
//  MainVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 8/17/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var seasonPicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedSeason = SEASON_YEAR_CURRENT
    var comparePlayer: Player?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        seasonPicker.dataSource = self
        seasonPicker.delegate = self
        
        if let player = comparePlayer {
            print(player.name)
            startButton.setTitle("Back", for: .normal)
            titleLabel.text = "Compare \(player.name) to:"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSelect" {
            if let destination = segue.destination as? SelectVC {
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
        attributedString = NSAttributedString(string: seasonSelectArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return seasonSelectArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        WebService.instance.SELECTED_SEASON = "Season=\(seasonSelectArray[row])&"
        selectedSeason = seasonSelectArray[row]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
