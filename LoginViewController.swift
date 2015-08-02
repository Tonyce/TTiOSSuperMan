//
//  LoginViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/2.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit


let kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
let kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"

protocol LoginViewControllerDelegate : class{
    func writeLoginStatus(loginStatus: [String: Int])
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    
    @IBOutlet weak var userName: MKTextField!
    @IBOutlet weak var password: MKTextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var loginBtnWidth: NSLayoutConstraint!
    @IBOutlet var loginRight: NSLayoutConstraint!
    
    var centerLayoutConstraint : NSLayoutConstraint?
    
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initElement()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.userName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissView(sender: AnyObject) {
        
        let userNameValue = userName.text!
        let passwordValue = password.text!
        self.loginBtn.enabled = false
        
        self.view.removeConstraint(self.loginRight)

        
        centerLayoutConstraint = NSLayoutConstraint(item: self.loginBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(self.centerLayoutConstraint!)
        self.loginBtnWidth.constant = self.registerBtn.frame.height
        self.loginBtn.setTitle("", forState: UIControlState.Normal)
        
        UIView.animateWithDuration(0.5, animations: {
                self.registerBtn.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: {
                _ in
                self.addMMSpinner()
                let requestBody = ["userName": userNameValue, "password": passwordValue]
                self.sendUserNameAndPwd("http://107.150.96.151/api/me/login", requestBody: requestBody)
        })
        
    }
    
    func sendUserNameAndPwd(url: String, requestBody: [String: String]){
        MyHTTPHandler.post(url, params: requestBody){
            
            data, err in
            dispatch_async(dispatch_get_main_queue(), {
                // code here
                let jsonParsed: AnyObject!
                if err != nil {
                    self.displayAlert("client goes wrong")
                    return
                }
                
//                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("\(strData)")
                do {
                    jsonParsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                    // print("json\(jsonParsed)")
                }catch _ {
                    print("err")
                    self.displayAlert("parse json goes wrong")
                    self.resumeLoginBtn()
                    return
                }
                
                let jsonResult = JSONValue.fromObject(jsonParsed)!
                let success = jsonResult["success"]?.bool
                if success == true {
                    self.logined()
                }else {
                    self.displayAlert("password is wrong")
                    self.resumeLoginBtn()
                }
            })
            
        }
    }
    
    func displayAlert(message: String){
        let alertController = UIAlertController(title: "登陆", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default,handler: {
            _ in
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func resumeLoginBtn(){
    
        self.ovalShapeLayer.removeFromSuperlayer()
        self.view.removeConstraint(self.centerLayoutConstraint!)
        self.view.addConstraint(self.loginRight)
        self.loginBtnWidth.constant = 120
        self.loginBtn.enabled = true
        
        UIView.animateWithDuration(0.1, animations: {
            
            self.registerBtn.alpha = 1
            self.view.layoutIfNeeded()
            
            }, completion: {
                _ in
                self.loginBtn.setTitle("Login", forState: UIControlState.Normal)
        })
    }
    

    func logined(){
        delegate?.writeLoginStatus(["login": 1])
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.userName.becomeFirstResponder()
        self.userName.resignFirstResponder()
    }
    func initElement(){
        
        loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame) / 2
        registerBtn.layer.cornerRadius = CGRectGetHeight(self.registerBtn.frame) / 2
        
        userName.layer.borderColor = UIColor.clearColor().CGColor
        userName.floatingPlaceholderEnabled = true
        userName.placeholder = "user name"
        userName.tintColor = UIColor.MKColor.BlueGrey
        userName.rippleLocation = .Right
        userName.cornerRadius = 0
        userName.bottomBorderEnabled = true
        
        
        password.layer.borderColor = UIColor.clearColor().CGColor
        password.floatingPlaceholderEnabled = true
        password.placeholder = "password"
        password.tintColor = UIColor.MKColor.BlueGrey
        password.rippleLocation = .Right
        password.cornerRadius = 0
        password.bottomBorderEnabled = true
    }
    
    @IBAction func registerAction(sender: AnyObject) {

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension LoginViewController {
    
    func addMMSpinner(){
        
        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 2.0
        ovalShapeLayer.frame = CGRectMake(0, 0, self.loginBtn.frame.width, self.loginBtn.frame.height)
        //        ovalShapeLayer.backgroundColor = UIColor.orangeColor().CGColor
        let refreshRadius = self.loginBtn.frame.size.height/2 * 0.5
        let path = UIBezierPath(ovalInRect: CGRect(
            x: self.loginBtn.frame.size.width/2 - refreshRadius,
            y: self.loginBtn.frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius))
        
        ovalShapeLayer.path = path.CGPath
        
        self.loginBtn.layer.addSublayer(ovalShapeLayer)
        beginRefreshing()
    }
    
    func beginRefreshing() {
        
        let animation = CABasicAnimation()
        //        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = "transform.rotation"
        animation.duration = 4.0;
        animation.fromValue = 0.0;
        animation.toValue = 2 * M_PI;
        animation.repeatCount = Float.infinity
        
        ovalShapeLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1.0;
        headAnimation.fromValue = 0.0;
        headAnimation.toValue = 0.25;
        
        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.delegate = self
        
        
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        
        let animations = CAAnimationGroup()
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        ovalShapeLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
    }
    
    func stopAnimate(){
        ovalShapeLayer.removeAnimationForKey(kMMRingRotationAnimationKey)
        ovalShapeLayer.removeAnimationForKey(kMMRingStrokeAnimationKey)
    }
}
