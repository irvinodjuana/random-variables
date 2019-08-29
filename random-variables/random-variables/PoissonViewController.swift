//
//  PoissonViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-24.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class PoissonViewController: UIViewController {
    
    @IBOutlet weak var lambda_text: UITextField!
    @IBOutlet weak var poissonChart: LineChartView!
    
    var probabilities = [Double]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
        chartUtils.setupChart(poissonChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        let lambda_value = Double(lambda_text.text!)
        
        if let lambda = lambda_value {
            if lambda > 0 {
                probabilities = [Double]()
                
                var k = 0
                var p_entry = 1.0
                while (p_entry > 0.0000001) {
                    p_entry = pow(lambda, Double(k)) * exp(-1 * lambda) / math.factorial(k)
                    probabilities.append(p_entry)
                    k += 1
                }
                
                chartUtils.updateChartDiscrete(poissonChart, probabilities)
                
            } else {
                // lambda inputted was less than or equal to 0
                print("Invalid: Lambda must be greater than 0")
            }
        } else {
            // Non-numeric value inputted into lambda
            print("Invalid lambda inputted")
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
