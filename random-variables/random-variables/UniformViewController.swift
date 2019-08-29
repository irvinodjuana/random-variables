//
//  UniformViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class UniformViewController: UIViewController {
    
    @IBOutlet weak var a_text: UITextField!
    @IBOutlet weak var b_text: UITextField!
    @IBOutlet weak var uniformChart: LineChartView!
    
    var probabilities = [(Double, Double)]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
        chartUtils.setupChart(uniformChart)
    }
    
    @IBAction func chartButton(_ sender: Any) {
        // Chart button pressed - input values into graph
        let a_value = Double(a_text.text!)
        let b_value = Double(b_text.text!)
        probabilities = [(Double, Double)]()
        
        if let a = a_value, let b = b_value {
            if (b > a) {
                // correct input
                let height = 1 / (b-a)
                probabilities.append((a, height))
                probabilities.append((b, height))

                chartUtils.updateChartContinuous(uniformChart, probabilities, circles: true)
                chartUtils.setChartBounds(chart: uniformChart,
                                          xMin: a - 0.75*(b-a), xMax: b + 0.75*(b-a),
                                          yMin: 0, yMax: 2/(b-a))
            } else {
                // invalid as b less than a
                print("Invalid: b must be greater than a")
            }
        } else {
            // one or more non-double values found in text field
            print("Invalid: one or more nil values found")
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
