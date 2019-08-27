//
//  BinomialViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class BinomialViewController: UIViewController {

    @IBOutlet weak var n_text: UITextField!
    @IBOutlet weak var p_text: UITextField!
    @IBOutlet weak var binomialChart: LineChartView!
    
    var probabilities = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup general style and formatting
        chartUtils.setupChart(binomialChart)
    }
    

    
    @IBAction func chartButton(_ sender: Any) {
        // Chart button pressed - generate chart from input parameters
        let n_value = Int(n_text.text!)
        let p_value = Double(p_text.text!)
        
        if let p = p_value, let n = n_value {
            // all inputs are correct numeric entries here
            if p < 0.0 || p > 1.0 {
                print("Invalid p-value, not between 0 and 1")
                //TODO: Handle correct error display later
            } else if n < 0 {
                print("Invalid n-value, must be greater than 0")
                //TODO: Handle correct error display later
            } else {
                let q = 1-p
                let description = "Binomial Distribution: (n = \(n), p = \(p))"
                probabilities = [Double]()
                
                for k in 0...n {
                    let p_entry = math.choose(n: n, k: k) * pow(p, Double(k)) * pow(q, Double(n-k))
                    probabilities.append(p_entry)
                }
                chartUtils.updateChartDiscrete(binomialChart, probabilities, description)
            }
            
        } else {
            // One or more non-numeric entries found for n / p
            print("Invalid entries for n or p.")
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
