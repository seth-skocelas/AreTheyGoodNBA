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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let one = playerOne {
            print("Player 1: \(one.name)")
        }
        
        if let two = playerTwo {
            print("Player 2: \(two.name)")
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
