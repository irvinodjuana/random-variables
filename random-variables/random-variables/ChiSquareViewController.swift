//
//  ChiSquareViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-24.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class ChiSquareViewController: UIViewController {
    
    @IBOutlet weak var df_text: UITextField!
    @IBOutlet weak var chisquareChart: LineChartView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chartButton(_ sender: Any) {
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
