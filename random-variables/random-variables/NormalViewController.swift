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
    
    
    @IBOutlet weak var mu_slider: UISlider!
    @IBOutlet weak var sigma_slider: UISlider!
    @IBOutlet weak var mu_text: UILabel!
    @IBOutlet weak var sigma_text: UILabel!
    @IBOutlet weak var normalChart: LineChartView!
    
    var probabilities = [(Double, Double)]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()

        // Do any additional setup after loading the view.
        mu_slider.minimumValue = -10
        mu_slider.maximumValue = 10
        mu_slider.value = 0
        sigma_slider.minimumValue = 0.1 // sigma must be > 0
        sigma_slider.maximumValue = 10
        sigma_slider.value = 1
        
        chartUtils.setupChart(normalChart)
        chartUtils.setupSliders([mu_slider, sigma_slider])
        sliderChanged()
    }
    
    func sliderChanged() {
        // Update graph view when one/more of slider is moved
        let mu = Double(mu_slider.value)
        let sigma = Double(sigma_slider.value)
        mu_text.text = String(format: "%3.1f", mu)
        sigma_text.text = String(format: "%3.1f", sigma)
        
        let lower = mu - 4 * sigma
        let upper = mu + 4 * sigma
        let step = (upper - lower) / 50
        var x = lower
        
        // Add 100 evenly spaced data points along normal distribution
        probabilities = [(Double, Double)]()
        while (x <= upper) {
            probabilities.append((x, pdf(x, mu, sigma)))
            x += step
        }
        
        chartUtils.updateChartContinuous(normalChart, probabilities)
        chartUtils.setChartBounds(chart: normalChart, xMin: -10, xMax: 10, yMin: 0, yMax: 0.5)
    }
    
    @IBAction func muChanged(_ sender: Any) {
        sliderChanged()
    }
    @IBAction func sigmaChanged(_ sender: Any) {
        sliderChanged()
    }
    
    func pdf(_ x: Double, _ mu: Double, _ sigma: Double) -> Double {
        // Returns pdf(x), the pdf of x of the normal distribution under mean (mu) and standard deviation (sigma)
        return (1/(sqrt(2 * Double.pi) * sigma)) * exp(-0.5 * pow(x - mu, 2) / pow(sigma,2))
    }
    
}
