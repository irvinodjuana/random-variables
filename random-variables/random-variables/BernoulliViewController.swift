//
//  BernoulliViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class BernoulliViewController: UIViewController {

    
    
    @IBOutlet weak var p_slider: UISlider!
    @IBOutlet weak var p_text: UILabel!
    @IBOutlet weak var bernoulliChart: LineChartView!
    var probabilities = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        
        // Setup general style and formatting
        chartUtils.setupChart(bernoulliChart)
        chartUtils.setupSliders([p_slider])
        sliderChanged("")
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        // Update graph when slider is moved
        let p = Double(p_slider.value)
        p_text.text = String(format: "%.2f", p)
        
        probabilities = [Double]()
        probabilities.append(1-p)
        probabilities.append(p)
        
        chartUtils.updateChartDiscrete(bernoulliChart, probabilities)
        chartUtils.setChartBoundsY(chart: bernoulliChart, yMin: 0, yMax: 1)
    }

}
