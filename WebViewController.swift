//
//  WebViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/30.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var closeBtn: UIButton!
//    var url:String? {
//        didSet {
//            loadWeb()
//        }
//    }
    var willLoadUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.redColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2

        // Do any additional setup after loading the view.
        var urlStr = "http://www.apple.com"
        if let loadUrl = self.willLoadUrl {
            urlStr = loadUrl
        }
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    func loadWeb(){
        
    }
    @IBAction func dismissView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
