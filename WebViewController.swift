//
//  WebViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/30.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
//    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webProcess: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    let bCircleLayer = CAShapeLayer()
    @IBOutlet weak var forwardBtn: UIButton!
    let fCircleLayer = CAShapeLayer()

    @IBOutlet weak var reloadBtn: UIButton!
    let rCircleLayer = CAShapeLayer()
    
    @IBOutlet weak var controlView: UIView!

    var willLoadUrl: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        WKWebViewConfiguration *theConfiguration =
//            [[WKWebViewConfiguration alloc] init];
//        [theConfiguration.userContentController
//        addScriptMessageHandler:self name:@"myApp"];
//        
//        _theWebView = [[WKWebView alloc] initWithFrame:self.view.frame
//        configuration:theConfiguration];
//        [_theWebView loadRequest:request];
//        [self.view addSubview:_theWebView];
        
        let configuration = WKWebViewConfiguration()
        let testScriptURL = NSBundle.mainBundle().pathForResource("test", ofType: "js")
        let testJS: String?
        do {
            testJS = try String(contentsOfFile:testScriptURL!, encoding:NSUTF8StringEncoding)
        } catch _ {
            testJS = nil
        }
        let testScript = WKUserScript(source: testJS!, injectionTime: .AtDocumentStart, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(testScript)
        
        configuration.userContentController.addScriptMessageHandler(self, name: "myApp")
        
        webView = WKWebView(frame: CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height - 40) , configuration: configuration)

        webView.navigationDelegate = self
        
        webProcess.tintColor = UIColor.grayColor()

        view.insertSubview(webView, belowSubview:controlView)
        
        closeBtn.alpha = 0.7

        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.redColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        


        bCircleLayer.path = UIBezierPath(ovalInRect: backBtn.bounds).CGPath
        bCircleLayer.strokeColor = UIColor.grayColor().CGColor
        bCircleLayer.lineWidth = 1
        bCircleLayer.fillColor = UIColor.clearColor().CGColor
        

        fCircleLayer.path = UIBezierPath(ovalInRect: backBtn.bounds).CGPath
        fCircleLayer.strokeColor = UIColor.grayColor().CGColor
        fCircleLayer.lineWidth = 1
        fCircleLayer.fillColor = UIColor.clearColor().CGColor
        
        rCircleLayer.path = UIBezierPath(ovalInRect: backBtn.bounds).CGPath
        rCircleLayer.strokeColor = self.reloadBtn.tintColor.CGColor
        rCircleLayer.lineWidth = 1
        rCircleLayer.fillColor = UIColor.clearColor().CGColor
        
        backBtn.setTitle(GoogleIcon.ebae, forState: UIControlState.Normal)
        backBtn.layer.cornerRadius = CGRectGetHeight(backBtn.frame) / 2
        // backBtn.layer.addSublayer(bCircleLayer)
        
        forwardBtn.setTitle(GoogleIcon.ebbc, forState: UIControlState.Normal)
        forwardBtn.layer.cornerRadius = CGRectGetHeight(forwardBtn.frame) / 2
        // forwardBtn.layer.addSublayer(fCircleLayer)

        reloadBtn.setTitle(GoogleIcon.ec2e, forState: UIControlState.Normal)
        reloadBtn.layer.cornerRadius = CGRectGetHeight(reloadBtn.frame) / 2
        // reloadBtn.layer.addSublayer(rCircleLayer)
        
        // Do any additional setup after loading the view.
        var urlStr = "http://www.apple.com"
        if let loadUrl = self.willLoadUrl {
            urlStr = loadUrl
        }

        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        
        backBtn.enabled = false
        forwardBtn.enabled = false;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .New, context: nil)
        titleLabel.text = ""
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.webView.removeObserver(self, forKeyPath: "loading", context: nil)
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        self.webView.removeObserver(self, forKeyPath: "title", context: nil)
        
        if (webView.loading) {
            webView.stopLoading()
        }
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    /** Overwrite this method if you want to be able to handle custom URL schemes that are launched
    * from your channel
    * \param request the request that is being sent
    *
    * You can use it like this:
    * NSURL* theURL = [request mainDocumentURL];
    * NSString* absoluteString = [theURL absoluteString];
    * if( [[absoluteString lowercaseString] hasPrefix:@"yourapp://"] )
    * {
    *   // do something
    *   return NO;
    * }
    * return YES;
    */
    //    - (BOOL) shouldStartLoadWithRequest:(NSURLRequest *) request;
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        let url = request.URL?.absoluteString
        print("url \(url)")
        
        decisionHandler(WKNavigationActionPolicy.Allow)
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
    }

    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func stopReload(sender: AnyObject) {
        if (webView.loading) {
            webView.stopLoading()
        } else {
            let request = NSURLRequest(URL:webView.URL!)
            webView.loadRequest(request)
        }
    }
}

extension WebViewController: WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        let sendData = message.body
        // print(sendData["message"])
        // print(sendData["email"])
        
        let email = sendData["email"] as! String
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
}

extension WebViewController: WKNavigationDelegate {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == "loading") {
            
            backBtn.enabled = webView.canGoBack
            self.bCircleLayer.strokeColor = backBtn.enabled ? self.backBtn.tintColor.CGColor : UIColor.grayColor().CGColor
            
            forwardBtn.enabled = webView.canGoForward
            self.fCircleLayer.strokeColor = forwardBtn.enabled ? self.forwardBtn.tintColor.CGColor : UIColor.grayColor().CGColor
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = webView.loading
            
            webView.loading ? reloadBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal) : reloadBtn.setTitle(GoogleIcon.ec2e, forState: UIControlState.Normal)
            
        } else if (keyPath == "estimatedProgress") {
            // webProcess.hidden = webView.estimatedProgress == 1
            webProcess.setProgress(Float(webView.estimatedProgress), animated: true)
        } else if (keyPath == "title") {
            titleLabel.text = webView.title!
        }
    }
}

extension WebViewController: UIScrollViewDelegate {
    
    func shadowTopView(){
        controlView.layer.shadowOpacity = 0.5
        controlView.layer.shadowOffset  = CGSize(width: 1, height: 1)
        controlView.layer.shadowColor   = UIColor.grayColor().CGColor
        // topView.layer.shadowRadius  = 10.0
    }
    
    func clearTopViewShadow(){
        controlView.layer.shadowOpacity = 0
        controlView.layer.shadowOffset  = CGSizeZero
        controlView.layer.shadowColor   = UIColor.clearColor().CGColor
    }
    
}
