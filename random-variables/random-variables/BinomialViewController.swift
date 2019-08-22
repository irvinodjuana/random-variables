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

    @IBOutlet weak var n_text: UITextField!
    @IBOutlet weak var p_text: UITextField!
    @IBOutlet weak var binomialChart: LineChartView!
    
    var probabilities = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        binomialChart.noDataText = ""
        
    }
    

    
    @IBAction func chartButton(_ sender: Any) {
        // Chart button pressed - generate chart from input parameters
        let n_value = Int(n_text.text!)
        let p_value = Double(p_text.text!)
        
        if n_value == nil || p_value == nil {
            // Check inputs are valid
            print("One or more nil values found")
        } else if p_value! < 0.0 || p_value! > 1.0 {
            print("Invalid p-value, not between 0 and 1")
            //TODO: Handle correct error display later
        } else if n_value! < 0 {
            print("Invalid n-value, must be greater than 0")
        } else {
            let p = p_value!
            let n = n_value!
            let q = 1-p
            probabilities = [Double]()
            
            for k in 0...n {
                let p_entry = choose(n: n, k: k) * pow(p, Double(k)) * pow(q, Double(n-k))
                probabilities.append(p_entry)
            }
            
            updateGraph(n, p)
        }
    }
    
    func updateGraph(_ n_value: Int, _ p_value: Double) {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<probabilities.count {
            let value = ChartDataEntry(x: Double(i), y: probabilities[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Binomial Distribution")
        line1.colors = [NSUIColor.clear]
        line1.circleColors = [NSUIColor.orange]
        line1.circleRadius = CGFloat(5)
        
        
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        binomialChart.data = data
        binomialChart.chartDescription?.text = "X ~ Bin(\(n_value), \(p_value))"
        
    }
    
    // Math Functions
    
    func factorial(_ n: Int) -> Double {
        // Returns n! (factorial of n) - uses double to handle larger ints
        if n == 0 {
            return 1
        }
        
        var product: Double = 1
        for i in 1...n {
            product *= Double(i)
        }
        return product
    }
    
    func choose(n: Int, k: Int) -> Double {
        // Returns binomial coefficient n choose k
        let numerator = factorial(n)
        let denominator = factorial(n - k) * factorial(k)
        return numerator / denominator
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
