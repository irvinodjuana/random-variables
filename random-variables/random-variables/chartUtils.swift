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
    
    static func setupChart(_ chartView: LineChartView) {
        // Setup basic line chart style format
        chartView.noDataText = ""
        chartView.chartDescription?.text = ""
        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0.0
        chartView.xAxis.granularity = 1
        
    }
    
    static func updateChart(_ chartView: LineChartView, _ probabilities: [Double], _ description: String, startIndex: Int = 0) {
        // Update the graph view with new parameters
        
        var lineChartEntry = [ChartDataEntry]()
        
        // Format doubles to correct datatype
        for i in startIndex..<probabilities.count {
            let value = ChartDataEntry(x: Double(i), y: probabilities[i])
            lineChartEntry.append(value)
        }
        
        // Format dataset into a line chart data set
        let line = LineChartDataSet(entries: lineChartEntry, label: description)
        line.colors = [NSUIColor.clear]
        line.circleColors = [NSUIColor.orange]
        line.circleRadius = CGFloat(5)
        
        // Add line to graph view
        let data = LineChartData()
        data.addDataSet(line)
        data.setDrawValues(false)
        chartView.data = data
    }
}




