//
//  ExponentialViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class ExponentialViewController: UIViewController {
    
    @IBOutlet weak var lambda_text: UITextField!
    @IBOutlet weak var exponentialChart: LineChartView!
    
    var probabilities = [(Double, Double)]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chartUtils.setupChart(exponentialChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let lambda_value = Double(lambda_text.text!)
        probabilities = [(Double, Double)]()
        
        if let lambda = lambda_value {
            let lower_bound = 0.00001
            
            if lambda > lower_bound {
                // correct input for lambda
                var x = 0.0
                var p_entry = 1.0
                let upper_x = (-1/lambda) * math.ln(lower_bound / lambda)
                let step = upper_x / 100
                
                while (x <= upper_x) {
                    p_entry = lambda * exp(-1 * lambda * x)
                    probabilities.append((x, p_entry))
                    x += step
                }
                
                chartUtils.updateChartContinuous(exponentialChart, probabilities)
                
            } else {
                // lambda inputted was <= 0
                print("Invalid: lambda inputted must be greater than 0")
            }
        } else {
            // non-Double value entered into lambda text field
            print("Invalid: lambda must be a numeric value")
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
