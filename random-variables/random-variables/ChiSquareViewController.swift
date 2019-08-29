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
    
    var probabilities = [(Double, Double)]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
        chartUtils.setupChart(chisquareChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let df_value = Int(df_text.text!)
        
        if let df_val = df_value {
            if df_val >= 1 {
                // correct input for df
                probabilities = [(Double, Double)]()
                
                let df = Double(df_val)
                let lower = max(0.0, df - 4.0 * sqrt(2.0 * df))
                print(lower)
                let upper = df + 4.0 * sqrt(2.0 * df)
                let step = (upper - lower) / 1000
                var x = lower + step
                
                while (x <= upper) {
                    probabilities.append((x, pdf(x, df)))
                    x += step
                }
                
                chartUtils.updateChartContinuous(chisquareChart, probabilities)
            } else {
                // df is an integer <= 0
                print("Invalid: df must be greater than 0")
            }
        } else {
            // Non-integer value inputted into df
            print("Invalid: df must be an integer greater than 0")
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
    
    func pdf(_ x: Double, _ df: Double) -> Double {
        // Returns the value for x under the pdf of the chi-square distribution
        if x <= 0.0 {
            return 0
        } else {
            return (pow(x, 0.5 * df - 1) * exp(-0.5 * x)) / (pow(2, 0.5 * df) * math.gamma(0.5 * df))
        }
    }

}
