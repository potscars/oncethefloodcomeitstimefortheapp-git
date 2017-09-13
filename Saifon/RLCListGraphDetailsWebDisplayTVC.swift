//
//  RLCListGraphDetailsWebDisplayTVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 28/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import WebKit

class RLCListGraphDetailsWebDisplayTVC: UITableViewCell, WKNavigationDelegate {
    
    @IBOutlet weak var uivRLCLGDWDTVCGraphView: UIView! = nil
    @IBOutlet weak var uilRLCLGDWDTVCLoadingDesc: UILabel!
    @IBOutlet weak var uiaivRLCLGDWDTVCLoadingProgress: UIActivityIndicatorView!
    var graphWebView: WKWebView?
    @IBOutlet weak var uivRLCLGDWDTVCLoadingFrame: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateGraph(_ viewController:UIViewController , urlInString:String) {
        
        //self.uivRLCLGDWDTVCGraphView.bounds = CGRectMake(uivRLCLGDWDTVCGraphView.bounds.origin.x, uivRLCLGDWDTVCGraphView.bounds.origin.y, UIScreen.mainScreen().fixedCoordinateSpace.bounds.width, uivRLCLGDWDTVCGraphView.bounds.size.height)
        
        let frameOriginX: CGFloat = uivRLCLGDWDTVCGraphView.bounds.origin.x
        let frameOriginY: CGFloat = uivRLCLGDWDTVCGraphView.bounds.origin.y
        let frameSizeWidth: CGFloat = UIScreen.main.fixedCoordinateSpace.bounds.width
        let frameSizeHeight: CGFloat = uivRLCLGDWDTVCGraphView.bounds.size.height
        
        //WaterLevelLibrary.graphFrameByPhoneSize(self.uivRLCLGDWDTVCGraphView)
    
        let viewBounds: CGRect = CGRect(x: frameOriginX, y: frameOriginY, width: frameSizeWidth, height: frameSizeHeight)

        
        let jScript: String = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=\(frameSizeWidth+100)'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let wkUScript: WKUserScript = WKUserScript.init(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUCController: WKUserContentController = WKUserContentController.init()
        wkUCController.addUserScript(wkUScript)
        
        let webConfig = WKWebViewConfiguration()
        webConfig.userContentController = wkUCController
        
        let graphURL: URL = URL(string: urlInString)!
        let graphRequest: URLRequest = URLRequest(url: graphURL)
        self.graphWebView = WKWebView(frame: viewBounds, configuration: webConfig)
        self.graphWebView?.navigationDelegate = self
        self.graphWebView!.load(graphRequest)
        self.uivRLCLGDWDTVCGraphView.layer.borderWidth = 1
        self.uivRLCLGDWDTVCGraphView.layer.borderColor = UIColor.lightGray.cgColor
        self.uivRLCLGDWDTVCGraphView.addSubview(self.graphWebView!)
        self.uivRLCLGDWDTVCGraphView.sendSubview(toBack: self.graphWebView!)
        
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("[RLCLGDWDTVC] Graph load error: \(error.localizedDescription)")
        
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("[RLCLGDWDTVC] Loading graph...")
        uivRLCLGDWDTVCLoadingFrame.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("[RLCLGDWDTVC] Graph loaded")
        uivRLCLGDWDTVCLoadingFrame.isHidden = true
    }
}
