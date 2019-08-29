//
//  GeometricViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class GeometricViewController: UIViewController {

    @IBOutlet weak var p_text: UITextField!
    @IBOutlet weak var geometricChart: LineChartView!
    
    var probabilities = [Double]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        chartUtils.setupChart(geometricChart)
    }
    

    @IBAction func chartButton(_ sender: Any) {
        let p_value = Double(p_text.text!)
        
        if let p = p_value {
            // p input is numeric
            if (p >= 0 && p <= 1) {
                // Correct input
                probabilities = [Double]()
                var k = 0
                var p_entry = 1.0
                
                // arbitrary limits set on number of data points placed on graph
                // geometric distribution is infinite
                while (p_entry > 0.0001 || k <= 10) && (k < 100) {
                    p_entry = pow(1-p, Double(k-1)) * p
                    probabilities.append(p_entry)
                    k += 1
                }
                
                chartUtils.updateChartDiscrete(geometricChart, probabilities, startIndex: 1)
                
            } else {
                // p input not between 0 and 1
                print("Invalid: p must be between 0 and 1")
            }
        } else {
            // Non-numeric entry for p found
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
