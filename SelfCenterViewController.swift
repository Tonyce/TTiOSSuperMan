//
//  SelfCenterViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SelfCenterViewController: UIViewController {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var selfScrollViewContainer: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var selfImage: UIImageView!
    
    var selfConfig: SelfConfig!
    var alphaView : UIView!
    
    let selfScrollViewContainerDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        
        let frame: CGRect = self.navigationController!.navigationBar.frame
        alphaView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height + 20))
//        [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        alphaView.backgroundColor = UIColor.redColor()
        alphaView.alpha = 0.3
        
        
        self.view.insertSubview(alphaView, belowSubview: self.navigationController!.navigationBar)
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
        saveBtn.setTitle(GoogleIcon.ebc4, forState: UIControlState.Normal)
        saveBtn.tintColor = UIColor.whiteColor()
        saveBtn.layer.cornerRadius = CGRectGetHeight(saveBtn.frame) / 2
        
        selfScrollViewContainer.frame = view.frame

        selfScrollViewContainer.contentSize = CGSize(width: view.bounds.width, height:  view.bounds.height )
        // selfScrollViewContainer.contentInset = selfScrollViewContainerDefaultContentInset
        
        selfImage.image = selfConfig.image
        textView.text = selfConfig.word
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.barTintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resignKbAction(sender: AnyObject) {
//        let keyWindow = UIApplication.sharedApplication().keyWindow
//        let firstResponder = keyWindow.
//        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//        [firstResponder resignFirstResponder];
//        textView.resignFirstResponder()
        self.view.endEditing(true)
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }

    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveSelfConfig" {
            // selfImage.image = UIImage(named: "me")
            let image: UIImage = selfImage.image!
            let word: String = textView.text
            selfConfig = SelfConfig(image: image, word: word)
        }
    }
}

//extension SelfCenterViewController: UINavigationControllerDelegate {
//    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
//        print(viewController)
//        if viewController == self {
//            print("...")
////             self.navigationController?.navigationBar.translucent = true
//            //        navigationController?.navigationBar.alpha = 0.0
//            //        navigationController?.navigationBar.barTintColor = UIColor.clearColor()
//            
//            self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//            self.navigationController!.navigationBar.shadowImage = UIImage()
//        }
//    }
//}

extension SelfCenterViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offset = scrollView.contentOffset.y
        let alpha = offset / 100
        alphaView.alpha = alpha
    }
}