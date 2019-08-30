//
//  BinomialViewController.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-18.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import UIKit
import Charts

class BinomialViewController: UIViewController {


    @IBOutlet weak var n_slider: UISlider!
    @IBOutlet weak var p_slider: UISlider!
    @IBOutlet weak var n_text: UILabel!
    @IBOutlet weak var p_text: UILabel!
    
    
    @IBOutlet weak var binomialChart: LineChartView!
    
    var probabilities = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Setup general style and formatting
        n_slider.maximumValue = 100
        n_slider.minimumValue = 1
        
        chartUtils.setupChart(binomialChart)
        chartUtils.setupSliders([n_slider, p_slider])
        sliderChanged()
        
    }
    
    @IBAction func nChanged(_ sender: Any) {
        sliderChanged()
    }
    @IBAction func pChanged(_ sender: Any) {
        sliderChanged()
    }
    
    func sliderChanged() {
        // Update graph with new slider values
        let p = Double(p_slider.value)
        let q = 1 - p
        let n = Int(n_slider.value.rounded())
        n_slider.setValue(Float(n), animated: false)
        probabilities = [Double]()
        
        p_text.text = String(format: "%.2f", p)
        n_text.text = String(format: "%3i", n)
        
        for k in 0...n {
            let p_entry = math.choose(n: n, k: k) * pow(p, Double(k)) * pow(q, Double(n-k))
            probabilities.append(p_entry)
        }
        chartUtils.updateChartDiscrete(binomialChart, probabilities)
        
    }

}
