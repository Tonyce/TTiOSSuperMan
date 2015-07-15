//
//  SelfCenterViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SelfCenterViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var selfScrollViewContainer: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var selfImage: UIImageView!
    
    var selfConfig: SelfConfig!
    
    let selfScrollViewContainerDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        
        if let image = selfConfig.image {
            selfConfig.image = image
            selfConfig.image = UIImage(named: "me")
        }else {
            selfConfig.image = UIImage(named: "defaultImage")
        }
        
        // Do any additional setup after loading the view.
        saveBtn.setTitle(GoogleIcon.ebc4, forState: UIControlState.Normal)
        saveBtn.tintColor = UIColor.whiteColor()
        saveBtn.layer.cornerRadius = CGRectGetHeight(saveBtn.frame) / 2
        
        selfScrollViewContainer.frame = view.frame

        selfScrollViewContainer.contentSize = CGSize(width: view.bounds.width, height:  view.bounds.height * 2)
        // selfScrollViewContainer.contentInset = selfScrollViewContainerDefaultContentInset
        
        selfImage.image = selfConfig.image
        textView.text = selfConfig.word
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let image: UIImage = selfImage.image!
        let word: String = textView.text
        selfConfig = SelfConfig(image: image, word: word)
    }
}

class SelfConfig: NSObject {
    var image: UIImage?
    var word: String?
    
    init(image: UIImage, word: String){
        super.init()
        self.image = image
        self.word = word
    }
}