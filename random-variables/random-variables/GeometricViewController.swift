//
//  GeometricViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class GeometricViewController: UIViewController {

    
    @IBOutlet weak var p_slider: UISlider!
    @IBOutlet weak var p_text: UILabel!
    @IBOutlet weak var geometricChart: LineChartView!
    
    var probabilities = [Double]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Do any additional setup after loading the view.
        p_slider.minimumValue = 0.01
        
        chartUtils.setupChart(geometricChart)
        chartUtils.setupSliders([p_slider])
        sliderChanged("")
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        // Update graph when slider is moved
        let p = Double(p_slider.value)
        p_text.text = String(format: "%.2f", p)
        
        // Correct input
        probabilities = [Double]()
        var k = 0
        var p_entry = 1.0
        
        // arbitrary limits set on number of data points placed on graph
        // geometric distribution is infinite
        while (p_entry > 0.0001 || k <= 10) && (k < 100) {
            p_entry = pow(1-p, Double(k-1)) * p
            probabilities.append(p_entry)
            k += 1
        }
        
        chartUtils.updateChartDiscrete(geometricChart, probabilities, startIndex: 1)
    }

}
