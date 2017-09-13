//
//  SaifonFirstRiverViewController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/08/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class SaifonFirstRiverViewController: UIViewController {

    @IBOutlet weak var uivSFRVCGraph: BEMSimpleLineGraphDelegate!
    @IBOutlet weak var uivSFRVCInfoBackg: UIView!
    @IBOutlet weak var uilSFRCVRiverName: UILabel!
    @IBOutlet weak var uilSFRVCRiverDate: UILabel!
    @IBOutlet weak var uilSFRVCRiverCurrLevel: UILabel!
    @IBOutlet weak var uilSFRVCRiverPrevLevel: UILabel!
    @IBOutlet weak var uilSFRVCRiverDifference: UILabel!
    @IBOutlet weak var uilSFRVCDangerLevel: UILabel!
    @IBOutlet weak var uilSFRVCWarningLevel: UILabel!
    @IBOutlet weak var uilSFRVCCautionLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //uivSFRVCGraph.delegate = self
        
        uilSFRCVRiverName.textColor = UIColor.whiteColor()
        uilSFRCVRiverName.text = getSungai1Data().valueForKey("location") as? String
        
        uilSFRVCRiverDate.textColor = UIColor.whiteColor()
        uilSFRVCRiverDate.text = Libraries.dateFormatConverter((getSungai1Data().valueForKey("receives")![0].valueForKey("date_receive") as? String)!)
        
        uilSFRVCRiverCurrLevel.textColor = UIColor.whiteColor()
        let currLevel: String = Libraries.waterLevelConvert((getSungai1Data().valueForKey("receives")![0].valueForKey("water_depth") as? String)!).stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        uilSFRVCRiverCurrLevel.text = currLevel
        
        uilSFRVCRiverPrevLevel.textColor = UIColor.whiteColor()
        let prevLevel: String = Libraries.waterLevelConvert((getSungai1Data().valueForKey("receives")![0].valueForKey("interval_depth") as? String)!).stringByReplacingOccurrencesOfString("(", withString: "").stringByReplacingOccurrencesOfString(")", withString: "")
        uilSFRVCRiverPrevLevel.text = "30 minit sebelum: \(prevLevel)"
        
        uilSFRVCRiverDifference.textColor = UIColor.whiteColor()
        let diffLevel: String = Libraries.waterLevelConvert((getSungai1Data().valueForKey("receives")![0].valueForKey("interval_different") as? String)!)
        uilSFRVCRiverDifference.text = diffLevel
        
        uilSFRVCDangerLevel.textColor = UIColor.whiteColor()
        uilSFRVCDangerLevel.text = Libraries.waterLevelConvert((getSungai1Data().valueForKey("danger") as? String)!)
        
        uilSFRVCWarningLevel.textColor = UIColor.whiteColor()
        uilSFRVCWarningLevel.text = Libraries.waterLevelConvert((getSungai1Data().valueForKey("warning") as? String)!)
        
        uilSFRVCCautionLevel.textColor = UIColor.whiteColor()
        uilSFRVCCautionLevel.text = Libraries.waterLevelConvert((getSungai1Data().valueForKey("caution") as? String)!)

        
        if(getSungai1Data().valueForKey("receives")![9].valueForKey("status") as! String == "3")
        {
            uivSFRVCInfoBackg.backgroundColor = ColorInHex.colorWithHexString("#F44336")
        }
        else if(getSungai1Data().valueForKey("receives")![9].valueForKey("status") as! String == "2")
        {
            uivSFRVCInfoBackg.backgroundColor = ColorInHex.colorWithHexString("#FFEB3B")
        }
        else
        {
            uivSFRVCInfoBackg.backgroundColor = ColorInHex.colorWithHexString("#4CAF50")
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("[SaifonFirstRiverController] Get First River Data: ",Double(NSNumberFormatter().numberFromString(getSungai1Data().valueForKey("receives")![0].valueForKey("water_depth") as! String)!))
        
        let xTime = [
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![9].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![8].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![7].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![6].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![5].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![4].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![3].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![2].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![1].valueForKey("date_receive") as! String),
            Libraries.dateFormatConverterForChart(getSungai1Data().valueForKey("receives")![0].valueForKey("date_receive") as! String)
        ]

        let yWaterLevel = [
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![9].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![8].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![7].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![6].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![5].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![4].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![3].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![2].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![1].valueForKey("water_depth") as! String),
            Libraries.waterDepthConverter(getSungai1Data().valueForKey("receives")![0].valueForKey("water_depth") as! String)
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
        
        let leftAxis: ChartYAxis = uivSFRVCGraph.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.addLimitLine(ll3)
        leftAxis._axisMaximum = 10.0
        leftAxis._axisMinimum = -10.0
        leftAxis.gridLineDashLengths = [CGFloat(5),CGFloat(5)]
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        uivSFRVCGraph.rightAxis.enabled = false
        
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
        self.uivSFRVCGraph.data = data
        
        //setupChart()
        */
        
        
        //LineGraph()
    }
    
    func getSungai1Data() -> NSDictionary
    {
        let mainTabController = tabBarController as! SaifonWLTabViewController
        //let dataReceived = mainTabController.sungai1.valueForKey("receives") as! NSArray
        
        return mainTabController.sungai1
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
