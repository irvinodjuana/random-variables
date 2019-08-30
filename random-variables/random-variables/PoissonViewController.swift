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
    

    @IBOutlet weak var lambda_slider: UISlider!
    @IBOutlet weak var lambda_text: UILabel!
    @IBOutlet weak var poissonChart: LineChartView!
    
    var probabilities = [Double]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
        lambda_slider.minimumValue = 0
        lambda_slider.maximumValue = 20
        lambda_slider.value = 1
        chartUtils.setupChart(poissonChart)
        chartUtils.setupSliders([lambda_slider])
        sliderChanged("")
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        // Update graph view when slider is moved
        let lambda = Double(lambda_slider.value)
        lambda_text.text = String(format: "%3.1f", lambda)
        probabilities = [Double]()
        
        var k = 0
        var p_entry = 1.0
        let upper = Int(lambda + 10 * sqrt(lambda))
        
        // chart extends up to 10 sd's away - theoretically infinite
        while (k <= upper) {
            p_entry = pow(lambda, Double(k)) * exp(-1 * lambda) / math.factorial(k) //pdf of poisson
            probabilities.append(p_entry)
            k += 1
        }
        
        chartUtils.updateChartDiscrete(poissonChart, probabilities)
    }
    
}
