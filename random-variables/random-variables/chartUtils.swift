//
//  chartUtils.swift
//  random-variables
//
//  Created by Irvino Djuana on 2019-08-24.
//  Copyright © 2019 Irvino Djuana. All rights reserved.
//

import Foundation
import Charts

class chartUtils {
    // Class for generic shared chart functions/methods
    
    // Shared variable style values
    static let themeColour = UIColor.magenta
    static let lineColour = themeColour.withAlphaComponent(0.4)
    static let gridColour = UIColor.lightGray.withAlphaComponent(0.5)
    static let circleRadius = 3.0
    
    static func setupSliders(_ sliders: [UISlider]) {
        // Setup general slider design
        for slider in sliders {
            slider.minimumTrackTintColor = themeColour
        }
        
    }
    
    static func setupChart(_ chartView: LineChartView) {
        // Setup basic line chart style format
        chartView.noDataText = ""
        chartView.chartDescription?.text = ""
        chartView.legend.enabled = false
        // x-axis properties
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.gridColor = gridColour
        // y-axis properties
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.gridColor = gridColour
        chartView.leftAxis.axisMinimum = 0.0
        chartView.rightAxis.enabled = false
    }
    
    static func updateChartDiscrete(_ chartView: LineChartView, _ probabilities: [Double], startIndex: Int = 0) {
        // Update the graph view with new probability set: discrete random variables
        
        let data = LineChartData()
        
        // Format doubles to correct datatype
        for i in startIndex..<probabilities.count {
            // Create vertical bar line for each probability
            var lineChartEntry = [ChartDataEntry]()
            var pointEntry = [ChartDataEntry]()
            
            let value0 = ChartDataEntry(x: Double(i), y: 0.0)
            let value = ChartDataEntry(x: Double(i), y: probabilities[i])
            lineChartEntry.append(value0)
            lineChartEntry.append(value)
            pointEntry.append(value)
            
            // Format dataset into a line chart data set
            let line = LineChartDataSet(entries: lineChartEntry, label: "")
            line.colors = [lineColour]
            line.circleColors = [NSUIColor.clear]
            line.circleRadius = CGFloat(0)
            
            let point = LineChartDataSet(entries: pointEntry, label: "")
            point.colors = [themeColour]
            point.circleColors = [themeColour]
            point.circleRadius = CGFloat(circleRadius)
            
            data.addDataSet(line)
            data.addDataSet(point)
        }
        
        // Add data to chart and format nicely
        data.setDrawValues(false)
        chartView.data = data
        chartView.xAxis.granularity = 1
        setChartBoundsX(chart: chartView, xMin: Double(startIndex) - 1.0, xMax: Double(probabilities.count))
    }
    
    static func updateChartContinuous(_ chartView: LineChartView, _ probabilities: [(Double, Double)], startIndex: Int = 0, circles: Bool = false) {
        // Update the graph view with new probability set: continuous random variables
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<probabilities.count {
            let (X,Y) = probabilities[i]
            let value = ChartDataEntry(x: X, y: Y)
            lineChartEntry.append(value)
        }
        
        // Format dataset into a line chart data set
        let line = LineChartDataSet(entries: lineChartEntry, label: "")
        line.colors = [themeColour]
        line.mode = .cubicBezier
        line.lineWidth = 1.5
        
        // gradient colors
        let gradientColours = [themeColour.cgColor, UIColor.clear.cgColor] as CFArray
//        let colourLocations: [CGFloat] = [CGFloat(min(math.max(probabilities), 1.0)), 0.0]
        let colourLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColours, locations: colourLocations) else {print("gradient error"); return}
        line.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line.drawFilledEnabled = true
        
        if circles {
            line.circleColors = [themeColour]
            line.circleRadius = CGFloat(circleRadius)
        } else {
            line.circleColors = [NSUIColor.clear]
            line.circleRadius = CGFloat(0)
        }
        
        // Add line to graph view
        let data = LineChartData()
        data.addDataSet(line)
        data.setDrawValues(false)
        chartView.data = data
        
    }
    
    static func setChartBounds(chart: LineChartView, xMin: Double, xMax: Double, yMin: Double, yMax:Double) {
        // Function to manually set x and y boundaries of chart
        setChartBoundsX(chart: chart, xMin: xMin, xMax: xMax)
        setChartBoundsY(chart: chart, yMin: yMin, yMax: yMax)
    }
    
    static func setChartBoundsX(chart: LineChartView, xMin: Double, xMax: Double) {
        // Function to manually set x boundaries of chart
        chart.xAxis.axisMinimum = xMin;
        chart.xAxis.axisMaximum = xMax;
    }
    
    static func setChartBoundsY(chart: LineChartView, yMin: Double, yMax: Double) {
        // Function to manually set y boundaries of chart
        chart.leftAxis.axisMinimum = yMin;
        chart.leftAxis.axisMaximum = yMax;
    }
    
}

// Extra View Controller extension to allow keyboard hiding
extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}







