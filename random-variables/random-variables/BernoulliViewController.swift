//
//  BernoulliViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class BernoulliViewController: UIViewController {

    @IBOutlet weak var p_text: UITextField!
    @IBOutlet weak var bernoulliChart: LineChartView!
    var probabilities = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Setup general style and formatting
        chartUtils.setupChart(bernoulliChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let p_value = Double(p_text.text!)
        
        if let p = p_value {
            // p is a numeric input
            if (p >= 0 && p <= 1) {
                // Correct input
                let p = p_value!
                probabilities = [Double]()
                probabilities.append(1-p)
                probabilities.append(p)
                
                chartUtils.updateChartDiscrete(bernoulliChart, probabilities)
                chartUtils.setChartBoundsY(chart: bernoulliChart, yMin: 0, yMax: 1)
                
            } else {
                // p-value found not between 0 and 1
                print("Invalid p-value: must be between 0 and 1")
            }
        } else {
            // Invalid text field for double value
            print("Invalid entry for p")
        }
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
