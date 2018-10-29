//
//  AppInfoVC.swift
//  AreTheyGoodNBA
//
//  Created by Seth Skocelas on 10/24/18.
//  Copyright © 2018 Seth Skocelas. All rights reserved.
//

import UIKit

class AppInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func returnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
