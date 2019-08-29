//
//  NormalViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class NormalViewController: UIViewController {
    
    @IBOutlet weak var mu_text: UITextField!
    @IBOutlet weak var sigma_text: UITextField!
    @IBOutlet weak var normalChart: LineChartView!
    
    var probabilities = [(Double, Double)]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chartUtils.setupChart(normalChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let mu_value = Double(mu_text.text!)
        let sigma_value = Double(sigma_text.text!)
        
        probabilities = [(Double, Double)]()
        
        if let mu = mu_value, let sigma = sigma_value {
            if sigma > 0 {
                // correct input for (mu), (sigma)
                
                // arbitrarily define range of graphed area as (mu) +/- 5(sigma)
                let lower = mu - 5 * sigma
                let upper = mu + 5 * sigma
                let step = sigma / 10  // 100 data points
                
                var x = lower
                
                // Add 100 evenly spaced data points along normal distribution
                while (x <= upper) {
                    probabilities.append((x, pdf(x, mu, sigma)))
                    x += step
                }
                
                chartUtils.updateChartContinuous(normalChart, probabilities)
            } else {
                // sigma inputted <= 0
                print("Invalid: sigma must be greater than 0")
            }
        } else {
            // Non-double values found in mu/sigma text fields
            print("Invalid: non-Double mu or sigma values found")
        }
    }
    
    func pdf(_ x: Double, _ mu: Double, _ sigma: Double) -> Double {
        // Returns pdf(x), the pdf of x of the normal distribution under mean (mu) and standard deviation (sigma)
        return (1/(sqrt(2 * Double.pi) * sigma)) * exp(-0.5 * pow(x - mu, 2) / pow(sigma,2))
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
