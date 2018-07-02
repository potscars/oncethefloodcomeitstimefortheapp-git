//
//  RiverLevelGraphCell.swift
//  Saifon
//
//  Created by Hainizam on 06/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Charts

class RiverLevelGraphCell: UITableViewCell {
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func awakeFromNib() {
        
        //chartView.delegate = self
        self.backgroundColor = .white
        chartView.backgroundColor = .white
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        chartView.chartDescription?.enabled = true
        chartView.chartDescription?.text = "20 bacaan paras air terakhir."
        
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.legend.enabled = true
        chartView.legend.form = .circle
        
        let xAxis = chartView.xAxis
        xAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.spaceMax = 2
        leftAxis.spaceMin = 2
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.enabled = false
    }
    
    func updateGraphUI(waterDepthValues: [Double]) {
        
        let count  = waterDepthValues.count
        let reversedWaterDepth: [Double] = waterDepthValues.reversed()
        
        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
            let val = reversedWaterDepth[i]
            print(val)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set = LineChartDataSet(values: yVals2, label: "Paras Air(m)")
        set.axisDependency = .left
        set.setColor(.lightBlue)
        
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 6)
        set.valueTextColor = .black
        
        set.lineWidth = 2
        set.circleRadius = 1
        set.fillAlpha = 1
        set.drawFilledEnabled = true
        set.fillColor = .white
        set.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set.drawCircleHoleEnabled = false
        set.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMaximum)
        }

        let data = LineChartData(dataSet: set)
        data.setDrawValues(true)
        data.setValueFormatter(DefaultValueFormatter(formatter: setupNumberFormatter(toDigits: 2)))
        
        chartView.data = data
    }
    
    func setupNumberFormatter(toDigits digit: Int) -> NumberFormatter {
        
        //change decimal format to 2 decimal.
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digit
        formatter.multiplier = 1.0
        
        return formatter
    }
}













