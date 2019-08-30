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
    
    
    @IBOutlet weak var b_slider: UISlider!
    @IBOutlet weak var a_slider: UISlider!
    @IBOutlet weak var a_text: UILabel!
    @IBOutlet weak var b_text: UILabel!
    @IBOutlet weak var uniformChart: LineChartView!
    
    var probabilities = [(Double, Double)]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Slider bounds setup
        a_slider.minimumValue = -5
        a_slider.maximumValue = 5
        a_slider.value = -1
        b_slider.minimumValue = -5.001  // slight offset to prevent slider matching error
        b_slider.maximumValue = 5.001
        b_slider.value = 1

        // Display setup
        chartUtils.setupChart(uniformChart)
        chartUtils.setupSliders([a_slider, b_slider])
        chartUtils.setChartBounds(chart: uniformChart, xMin: -5, xMax: 5, yMin: 0, yMax: 1)
        sliderChanged(a_slider)
    }
    
    func sliderChanged(_ sender: UISlider) {
        // Update graph when slider view found
        let a = Double(a_slider.value)
        let b = Double(b_slider.value)
        a_text.text = String(format: "%3.2f", a)
        b_text.text = String(format: "%3.2f", b)
        
        probabilities = [(Double, Double)]()
        
        if b > a {
            // valid input values
            let height = 1 / (b-a)
            probabilities.append((a, height))
            probabilities.append((b, height))
        
            chartUtils.updateChartContinuous(uniformChart, probabilities, circles: true)
            
        } else {
            // invalid input: a >= b, move sliders to match
            if sender == a_slider {
                b_slider.value = a_slider.value + 0.001
                sliderChanged(a_slider)
            } else if sender == b_slider {
                a_slider.value = b_slider.value - 0.001
                sliderChanged(a_slider)
            }
        }
    }
    
    @IBAction func aChanged(_ sender: Any) {
        sliderChanged(a_slider)
    }
    
    @IBAction func bChanged(_ sender: Any) {
        sliderChanged(b_slider)
    }

}
