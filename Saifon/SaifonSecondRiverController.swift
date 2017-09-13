//
//  SaifonSecondRiverController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/08/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class SaifonSecondRiverController: UIViewController {
    
    @IBOutlet weak var uivSSRCRiverInfoBack: UIView!
    @IBOutlet weak var uilSSRCRiverName: UILabel!
    @IBOutlet weak var uilSRCCRiverDate: UILabel!
    @IBOutlet weak var uilSRCCRiverCurrLevel: UILabel!
    @IBOutlet weak var uilSRCCRiverPrevLevel: UILabel!
    @IBOutlet weak var uilSRCCRiverDiffLevel: UILabel!
    @IBOutlet weak var uilSRCCDangerLevel: UILabel!
    @IBOutlet weak var uilSRCCWarningLevel: UILabel!
    @IBOutlet weak var uilSRCCCautionLevel: UILabel!
    @IBOutlet weak var uivSSRCGraphView: BEMSimpleLineGraphView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //uivSSRCGraphView.delegate = self
        
        uilSSRCRiverName.textColor = UIColor.whiteColor()
        uilSSRCRiverName.text = getSungai2Data().valueForKey("location") as? String
        
        uilSRCCRiverDate.textColor = UIColor.whiteColor()
        uilSRCCRiverDate.text = Libraries.dateFormatConverter((getSungai2Data().valueForKey("receives")![0].valueForKey("date_receive") as? String)!)
        
        uilSRCCRiverCurrLevel.textColor = UIColor.whiteColor()
        let currLevel: String = Libraries.waterLevelConvert((getSungai2Data().valueForKey("receives")![0].valueForKey("water_depth") as? String)!).stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        uilSRCCRiverCurrLevel.text = currLevel
        
        uilSRCCRiverPrevLevel.textColor = UIColor.whiteColor()
        let prevLevel: String = Libraries.waterLevelConvert((getSungai2Data().valueForKey("receives")![0].valueForKey("interval_depth") as? String)!).stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        uilSRCCRiverPrevLevel.text = "30 minit sebelum: \(prevLevel)"
        
        uilSRCCRiverDiffLevel.textColor = UIColor.whiteColor()
         let diffLevel: String = Libraries.waterLevelConvert((getSungai2Data().valueForKey("receives")![0].valueForKey("interval_different") as? String)!)
        uilSRCCRiverDiffLevel.text = diffLevel
        
        uilSRCCDangerLevel.textColor = UIColor.whiteColor()
        uilSRCCDangerLevel.text = Libraries.waterLevelConvert((getSungai2Data().valueForKey("danger") as? String)!)
        
        uilSRCCWarningLevel.textColor = UIColor.whiteColor()
        uilSRCCWarningLevel.text = Libraries.waterLevelConvert((getSungai2Data().valueForKey("warning") as? String)!)
        
        uilSRCCCautionLevel.textColor = UIColor.whiteColor()
        uilSRCCCautionLevel.text = Libraries.waterLevelConvert((getSungai2Data().valueForKey("caution") as? String)!)

        if(getSungai2Data().valueForKey("receives")![9].valueForKey("status") as! String == "3")
        {
            uivSSRCRiverInfoBack.backgroundColor = ColorInHex.colorWithHexString("#F44336")
        }
        else if(getSungai2Data().valueForKey("receives")![9].valueForKey("status") as! String == "2")
        {
            uivSSRCRiverInfoBack.backgroundColor = ColorInHex.colorWithHexString("#FFEB3B")
        }
        else
        {
            uivSSRCRiverInfoBack.backgroundColor = ColorInHex.colorWithHexString("#4CAF50")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        setupChart()
    }
    
    func setupChart()
    {
        let mainTabController = tabBarController as! SaifonWLTabViewController
        let dataReceived = mainTabController.sungai2.valueForKey("receives") as! NSArray
        
        print("[SaifonFirstRiverController] Get First River Data: ",Double(NSNumberFormatter().numberFromString(dataReceived[0].valueForKey("water_depth") as! String)!))
        
        let xTime = [
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![9].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![8].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![7].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![6].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![5].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![4].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![3].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![2].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![1].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai2Data().valueForKey("receives")![0].valueForKey("date_receive") as! String)
        ]
        
        let yWaterLevel = [
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![9].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![8].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![7].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![6].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![5].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![4].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![3].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![2].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![1].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai2Data().valueForKey("receives")![0].valueForKey("water_depth") as! String)
        ]
        /*
        let ll1 = ChartLimitLine.init(limit: 3.5, label: "Danger")
        ll1.lineWidth = 4.0
        ll1.lineDashLengths = [CGFloat(5),CGFloat(5)]
        ll1.labelPosition = ChartLimitLine.LabelPosition.RightBottom
        ll1.valueFont = UIFont.systemFontOfSize(CGFloat(10))
        ll1.lineColor = UIColor.redColor()
        
        let ll2 = ChartLimitLine.init(limit: 3.0, label: "Warning")
        ll2.lineWidth = 4.0
        ll2.lineDashLengths = [CGFloat(5),CGFloat(5)]
        ll2.labelPosition = ChartLimitLine.LabelPosition.RightBottom
        ll2.valueFont = UIFont.systemFontOfSize(CGFloat(10))
        ll2.lineColor = UIColor.orangeColor()
        
        let ll3 = ChartLimitLine.init(limit: 2.5, label: "Caution")
        ll3.lineWidth = 4.0
        ll3.lineDashLengths = [CGFloat(5),CGFloat(5)]
        ll3.labelPosition = ChartLimitLine.LabelPosition.RightBottom
        ll3.valueFont = UIFont.systemFontOfSize(CGFloat(10))
        ll3.lineColor = UIColor.yellowColor()
        
        let leftAxis: ChartYAxis = uivSSRCGraphView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.addLimitLine(ll3)
        leftAxis._axisMaximum = 10.0
        leftAxis._axisMinimum = -10.0
        leftAxis.gridLineDashLengths = [CGFloat(5),CGFloat(5)]
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        uivSSRCGraphView.rightAxis.enabled = false
        
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< xTime.count {
            yVals1.append(ChartDataEntry(value: yWaterLevel[i], xIndex: i))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: "Paras Air")
        set1.axisDependency = .Left // Line will correlate with left axis values
        set1.setColor(UIColor.blueColor().colorWithAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.blueColor()) // our circle will be dark red
        set1.lineWidth = 1.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.redColor()
        set1.highlightColor = UIColor.whiteColor()
        set1.drawCircleHoleEnabled = true
        
        let gradientColors: NSArray = [ChartColorTemplates.colorFromString("#0009A7FF").CGColor as AnyObject, ChartColorTemplates.colorFromString("#ff0927FF").CGColor as AnyObject]
        
        let gradient: CGGradient = CGGradientCreateWithColors(nil, gradientColors as CFArrayRef, nil)!
        
        set1.fill = ChartFill.fillWithLinearGradient(gradient, angle: CGFloat(90))
        set1.drawFilledEnabled = true
        
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(xVals: xTime, dataSets: dataSets)
        data.setValueTextColor(UIColor.blackColor())
        
        //5 - finally set our data
        self.uivSSRCGraphView.data = data
        */
    }
    
    func getSungai2Data() -> NSDictionary
    {
        let mainTabController = tabBarController as! SaifonWLTabViewController
        //let dataReceived = mainTabController.sungai1.valueForKey("receives") as! NSArray
        
        return mainTabController.sungai2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
