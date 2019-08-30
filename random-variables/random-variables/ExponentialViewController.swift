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
    

    @IBOutlet weak var lambda_slider: UISlider!
    @IBOutlet weak var lambda_text: UILabel!
    @IBOutlet weak var exponentialChart: LineChartView!
    
    var probabilities = [(Double, Double)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Slider bounds setup
        lambda_slider.minimumValue = 0.1
        lambda_slider.maximumValue = 10
        lambda_slider.value = 5

        // Display setup
        chartUtils.setupChart(exponentialChart)
        chartUtils.setupSliders([lambda_slider])
        chartUtils.setChartBounds(chart: exponentialChart, xMin: 0, xMax: 1, yMin: 0, yMax: 10)
        sliderChanged("")
    }
    
    
    @IBAction func sliderChanged(_ sender: Any) {
        // Update graph when slider value is changed
        let lambda = Double(lambda_slider.value)
        lambda_text.text = String(format: "%3.1f", lambda)
        probabilities = [(Double, Double)]()
        
//        let lower_bound = Double(lambda_slider.minimumValue * 0.9)
        var x = 0.0
        var p_entry = 1.0
        let upper_x = 12 / lambda
        let step = upper_x / 100
        
        while (x <= upper_x && x <= 10) {
            p_entry = lambda * exp(-1 * lambda * x)
            probabilities.append((x, p_entry))
            x += step
        }
        
        chartUtils.updateChartContinuous(exponentialChart, probabilities)
    }

}
