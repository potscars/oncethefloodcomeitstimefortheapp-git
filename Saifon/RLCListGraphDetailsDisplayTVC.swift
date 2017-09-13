//
//  RLCListGraphDetailsDisplayTVC.swift
//  Saifon
//
//  Al-Jawaher - Mohon Padanya Sujud Padanya.mp3
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class RLCListGraphDetailsDisplayTVC: UITableViewCell, BEMSimpleLineGraphDelegate {

    @IBOutlet weak var uiscRLCDDTVCDuration: UISegmentedControl!
    @IBOutlet weak var lcvRLCDDTVCChart: BEMSimpleLineGraphView!
    
    var labelValues: String = ""
    var labelDates: String = ""
    var arrayOfWaterLevel: NSArray = []
    var arrayOfDate: NSArray = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("[RLCListGraphDetailsDisplayTVC] Running?")
        
        uiscRLCDDTVCDuration.addTarget(self, action: #selector(setDurationAction(_:)), for: UIControlEvents.valueChanged)
        
        lcvRLCDDTVCChart.delegate = self
        lcvRLCDDTVCChart.dataSource = self
        
    }
    
    func initializeGraph() {
        
        //lcvRLCDDTVCChart.gradientBottom = nil
        
        let colorspace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let num_locations: size_t = 2
        let locations: [CGFloat] = [ 0.0, 1.0 ]
        let components: [CGFloat] = [ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0 ]

        //lcvRLCDDTVCChart.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations)!
        lcvRLCDDTVCChart.gradientBottomBundled = [colorspace, num_locations, locations, components]
        
        // Enable and disable various graph properties and axis displays
        lcvRLCDDTVCChart.enableTouchReport = true
        lcvRLCDDTVCChart.enablePopUpReport = true
        lcvRLCDDTVCChart.enableYAxisLabel = true
        lcvRLCDDTVCChart.enableXAxisLabel = true
        lcvRLCDDTVCChart.autoScaleYAxis = true
        lcvRLCDDTVCChart.alwaysDisplayDots = true
        lcvRLCDDTVCChart.enableReferenceXAxisLines = true
        lcvRLCDDTVCChart.enableReferenceYAxisLines = true
        lcvRLCDDTVCChart.enableReferenceAxisFrame = true
        
        // Draw an average line
        lcvRLCDDTVCChart.averageLine.enableAverageLine = true
        lcvRLCDDTVCChart.averageLine.alpha = 0.6
        lcvRLCDDTVCChart.averageLine.color = UIColor.darkGray
        lcvRLCDDTVCChart.averageLine.width = 2.5
        lcvRLCDDTVCChart.averageLine.dashPattern = [ 2 , 2 ]
        
        // Set the graph's animation style to draw, fade, or none
        lcvRLCDDTVCChart.animationGraphStyle = BEMLineAnimation.draw;
        
        // Dash the y reference lines
        lcvRLCDDTVCChart.lineDashPatternForReferenceYAxisLines = [ 2 , 2 ];
        
        // Show the y axis values with this format string
        lcvRLCDDTVCChart.formatStringForValues = "%.1f";
        
        // Setup initial curve selection segment
        //lcvRLCDDTVCChart.selectedSegmentIndex = self.myGraph.enableBezierCurve;
        
        // The labels to report the values of the graph when the user touches it
        //lcvRLCDDTVCChart.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        //saifon.app/dashboard/mobile/1
    }
    
    func collectData(xAxis: NSArray, yAxis: NSArray) {
        
        self.arrayOfWaterLevel = yAxis
        self.arrayOfDate = xAxis
        
        //Draw an custom line
        
        let dangerLevelIndicator: NSDictionary =
            ["CUSTOM_LINE_START_POINT" : 55000,
             "CUSTOM_LINE_END_POINT" : 55000,
             "CUSTOM_LINE_WIDTH" : 2.5,
             "CUSTOM_LINE_ALPHA" : 0.6,
             "CUSTOM_LINE_DASHPATTERN" : [ 2 , 2 ],
             "CUSTOM_LINE_COLOR" : UIColor.red]
        
        let warningLevelIndicator: NSDictionary =
            ["CUSTOM_LINE_START_POINT" : 50000,
             "CUSTOM_LINE_END_POINT" : 50000,
             "CUSTOM_LINE_WIDTH" : 2.5,
             "CUSTOM_LINE_ALPHA" : 0.6,
             "CUSTOM_LINE_DASHPATTERN" : [ 2 , 2 ],
             "CUSTOM_LINE_COLOR" : UIColor.red]
        
        let cautionLevelIndicator: NSDictionary =
            ["CUSTOM_LINE_START_POINT" : 75000,
             "CUSTOM_LINE_END_POINT" : 75000,
             "CUSTOM_LINE_WIDTH" : 2.5,
             "CUSTOM_LINE_ALPHA" : 0.6,
             "CUSTOM_LINE_DASHPATTERN" : [ 2 , 2 ],
             "CUSTOM_LINE_COLOR" : UIColor.red]
        
        lcvRLCDDTVCChart.requiredCustomLineData = [dangerLevelIndicator]
    }
    
    // SimpleLineGraph Delegate
    
    func numberOfGapsBetweenLabels(onLineGraph graph: BEMSimpleLineGraphView) -> Int {
        return 1
    }
    
    func numberOfYAxisLabels(onLineGraph graph: BEMSimpleLineGraphView) -> Int {
        return 3
    }

    /*func lineGraph(_ graph: BEMSimpleLineGraphView, labelOnXAxisFor index: Int) -> String {
        return String(describing: self.arrayOfDate[index])
    }*/
    
    func didTouchGraph(withClosestIndex index: Int32) {
        
        
        
    }
    
    func didReleaseGraph(withClosestIndex index: Float) {
        
        UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options: UIViewAnimationOptions.curveEaseOut,
                                   animations: {
                                    
                                    
                                    
            },
                                   completion:  { (finished: Bool) in
                                    
                                    
        })
        
    }
    
    func lineGraphDidFinishDrawing(_ graph: BEMSimpleLineGraphView) {
        
    }
    
    func popUpSuffixForlineGraph(_ graph: BEMSimpleLineGraphView) -> String {
        return " meter"
    }
    
    
    func updateCell(_ data: NSArray)
    {
        print("[RLCListGraphDetailsDisplayTVC] Data received: \(data)")
        
        let xTimeMutable: NSMutableArray = []
        
        for index in (0...9).reversed() {
            
            let roundDecimalString: String = String(format: "%.2f", round(1000*Libraries.dateFormatConverterForChart((data[index] as AnyObject).value(forKey: "date_receive") as! String))/1000)
            
            let roundDecimalDouble: Double = Double(roundDecimalString)!
            
            xTimeMutable.add(roundDecimalDouble)
        
        }
        
        let xTime: NSArray = xTimeMutable.copy() as! NSArray
        
        let yWaterLevelMutable: NSMutableArray = []
        
        for indexY in (0...9).reversed() {
            
            let roundDecimal = Libraries.waterDepthConverter((data[indexY] as AnyObject).value(forKey: "water_depth") as! String)
            
            yWaterLevelMutable.add(roundDecimal)
            
        }
        
        let yWaterLevel: NSArray = yWaterLevelMutable.copy() as! NSArray
        
        
        
        print("[RLCListGraphDetailsDisplayTVC] X-Pos: \(xTime as! [NSObject]), Y-Pos: \(yWaterLevel)")
        
        let dangerLevel: Double = Double(((data[0] as AnyObject).value(forKey: "location") as AnyObject).value(forKey: "danger") as! String)!
        let warningLevel: Double = Double(((data[0] as AnyObject).value(forKey: "location") as AnyObject).value(forKey: "warning") as! String)!
        let cautionLevel: Double = Double(((data[0] as AnyObject).value(forKey: "location") as AnyObject).value(forKey: "caution") as! String)!
        
        print("[RLCListGraphDetailsDisplayTVC] Danger: \(dangerLevel), Warning: \(warningLevel), Caution: \(cautionLevel)")
        
        collectData(xAxis: xTime, yAxis: yWaterLevel)
        initializeGraph()
        
    }
    
    func setDurationAction(_ sender: UISegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            print("[RLCListGraphDetailsDisplayTVC] Sehari selected")
        }
        else if (sender.selectedSegmentIndex == 1)
        {
            print("[RLCListGraphDetailsDisplayTVC] Seminggu selected")
        }
        else if (sender.selectedSegmentIndex == 2)
        {
            print("[RLCListGraphDetailsDisplayTVC] Sebulan selected")
        }
        else if (sender.selectedSegmentIndex == 3)
        {
            print("[RLCListGraphDetailsDisplayTVC] Setahun selected")
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension RLCListGraphDetailsDisplayTVC: BEMSimpleLineGraphDataSource {
    
    func numberOfPoints(inLineGraph graph: BEMSimpleLineGraphView) -> Int {
     
        return self.arrayOfWaterLevel.count
     }
     
     func lineGraph(_ graph: BEMSimpleLineGraphView, valueForPointAt index: Int) -> CGFloat {
     
        return CGFloat(self.arrayOfWaterLevel[index] as! CGFloat)
     }
}

















