//
//  BakIntroViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/6.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class BakIntroViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "登陆备份"
        
        let htmlStr =  "<html><head><style>h1 {color: red}</style></head><body><h1>hello</h1></body></html>"
        
        webView.loadHTMLString(htmlStr, baseURL: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
