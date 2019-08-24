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
        
        // Setup general style and formatting
        chartUtils.setupGraph(bernoulliChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let p_value = Double(p_text.text!)
        
        if p_value == nil {
            print("nil value found")
        } else if (p_value! < 0 || p_value! > 1) {
            print("Invalid p-value: must be between 0 and 1")
        } else {
            probabilities = [Double]()
            probabilities.append(1-p_value!)
            probabilities.append(p_value!)
            let description = "Bernoulli Distribution: (p = \(p_value!))"
            chartUtils.updateGraph(bernoulliChart, probabilities, description)
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
