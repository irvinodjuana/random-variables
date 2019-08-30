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
    

    @IBOutlet weak var df_slider: UISlider!
    @IBOutlet weak var df_text: UILabel!
    @IBOutlet weak var chisquareChart: LineChartView!
    
    var probabilities = [(Double, Double)]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Slider bounds setup
        df_slider.minimumValue = 1
        df_slider.maximumValue = 20
        df_slider.value = 5

        // Display setup
        chartUtils.setupChart(chisquareChart)
        chartUtils.setupSliders([df_slider])
        chartUtils.setChartBoundsY(chart: chisquareChart, yMin: 0, yMax: 1.5)
        sliderChanged("")
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        let df = Double(df_slider.value.rounded())
//        df_slider.setValue(Float(df), animated: false)
        df_text.text = String(format: "%3i", Int(df))
        
        probabilities = [(Double, Double)]()

        let lower = max(0.0, df - 4.0 * sqrt(2.0 * df))
        let upper = df + 4.0 * sqrt(2.0 * df)
        let step = (upper - lower) / 100
        var x = lower + step
        
        while (x <= upper) {
            probabilities.append((x, pdf(x, df)))
            x += step
        }
        
        chartUtils.updateChartContinuous(chisquareChart, probabilities)
        
    }
    
    func pdf(_ x: Double, _ df: Double) -> Double {
        // Returns the value for x under the pdf of the chi-square distribution
        if x <= 0.0 {
            return 0
        } else {
            return (pow(x, 0.5 * df - 1) * exp(-0.5 * x)) / (pow(2, 0.5 * df) * math.gamma(0.5 * df))
        }
    }

}
