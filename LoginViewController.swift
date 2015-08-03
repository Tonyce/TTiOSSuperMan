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

    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var userName: MKTextField!
    @IBOutlet weak var password: MKTextField!
    @IBOutlet weak var conformPassword: MKTextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var loginBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var loginBtnTop: NSLayoutConstraint!
    @IBOutlet weak var registerBtnTop: NSLayoutConstraint!
    @IBOutlet weak var registerBtnWidth: NSLayoutConstraint!
    
    @IBOutlet var loginRight: NSLayoutConstraint!
    @IBOutlet var registerLeft: NSLayoutConstraint!
    
    @IBOutlet var conformCenter: NSLayoutConstraint!
    @IBOutlet weak var conformLeft: NSLayoutConstraint!
    
    var centerLayoutConstraint : NSLayoutConstraint?

    var registerText: String?
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        dismissBtn.tintColor = UIColor.whiteColor()
        dismissBtn.layer.cornerRadius = CGRectGetHeight(dismissBtn.frame) / 2
        
        conformFeildHidden()
        
        initElement()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.userName.becomeFirstResponder()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func login(){
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
                self.addMMSpinner(self.loginBtn)
                let requestBody = ["userName": userNameValue, "password": passwordValue]
                self.sendUserNameAndPwd("http://107.150.96.151/api/me/login", requestBody: requestBody, isLogin: true)
        })
    }
    
    func register(){
        let userNameValue = userName.text!
        let passwordValue = password.text!
        let conformedPassword = conformPassword.text!
        
        if conformedPassword != passwordValue {
            self.displayAlert("两次输入的密码不一样")
            return
        }
        
        self.registerBtn.enabled = false
        
        self.view.removeConstraint(self.registerLeft)
        
        
        centerLayoutConstraint = NSLayoutConstraint(item: self.registerBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(self.centerLayoutConstraint!)
        self.registerBtnWidth.constant = self.registerBtn.frame.height
        self.registerBtn.setTitle("", forState: UIControlState.Normal)
        
        UIView.animateWithDuration(0.5, animations: {
            self.loginBtn.alpha = 0
            self.view.layoutIfNeeded()
            }, completion: {
                _ in
                self.addMMSpinner( self.registerBtn)
                let requestBody = ["userName": userNameValue, "password": passwordValue]
                self.sendUserNameAndPwd("http://107.150.96.151/api/me/login", requestBody: requestBody, isLogin: false)
        })
    }
    
    func sendUserNameAndPwd(url: String, requestBody: [String: String], isLogin: Bool){
        MyHTTPHandler.post(url, params: requestBody){
            
            data, err in
            dispatch_async(dispatch_get_main_queue(), {

                let jsonParsed: AnyObject!
                if err != nil {
                    self.displayAlert("client goes wrong")
                    return
                }
                
                do {
                    jsonParsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                }catch _ {
                    print("err")
                    self.displayAlert("parse json goes wrong")
                    if isLogin {
                        self.resumeLoginBtn()
                    }else {
                        self.resumeRegisterBtn()
                    }

                    return
                }
                
                let jsonResult = JSONValue.fromObject(jsonParsed)!
                let success = jsonResult["success"]?.bool
                if success == true {
                    self.logined()
                }else {
                    self.displayAlert("password is wrong")
                    if isLogin {
                        self.resumeLoginBtn()
                    }else {
                        self.resumeRegisterBtn()
                    }
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
    
    func resumeRegisterBtn(){
    
        self.ovalShapeLayer.removeFromSuperlayer()
        self.view.removeConstraint(self.centerLayoutConstraint!)
        self.view.addConstraint(self.registerLeft)
        
        self.registerBtnWidth.constant = 120
        self.registerBtn.enabled = true
        
        UIView.animateWithDuration(0.1, animations: {
            
            self.loginBtn.alpha = 1
            self.view.layoutIfNeeded()
            
            }, completion: {
                _ in
                self.registerBtn.setTitle("ok", forState: UIControlState.Normal)
        })
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
                self.loginBtn.setTitle("登陆", forState: UIControlState.Normal)
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
        
        conformPassword.layer.borderColor = UIColor.clearColor().CGColor
        conformPassword.floatingPlaceholderEnabled = true
        conformPassword.placeholder = "conform password"
        conformPassword.tintColor = UIColor.MKColor.BlueGrey
        conformPassword.rippleLocation = .Right
        conformPassword.cornerRadius = 0
        conformPassword.bottomBorderEnabled = true
    }
    
    @IBAction func registerAction(sender: AnyObject) {
        registerText = registerBtn.currentTitle
        if registerText == "注册" {
            conformFeildShow()
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
                self.registerBtn.setTitle("ok", forState: UIControlState.Normal)
                self.loginBtn.setTitle("cancel", forState: UIControlState.Normal)
                self.loginBtn.tintColor = UIColor.whiteColor()
                self.loginBtn.backgroundColor = UIColor.redColor()
            })

        }
        if registerText == "ok" {
            //register
            self.register()
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        if loginBtn.currentTitle == "登陆" {
            self.login()
        }
        
        if loginBtn.currentTitle == "cancel" {
            conformFeildHidden()
            UIView.animateWithDuration(0.5, animations: {
                self.view.layoutIfNeeded()
                self.registerBtn.setTitle("注册", forState: UIControlState.Normal)
                self.loginBtn.setTitle("登陆", forState: UIControlState.Normal)
                self.loginBtn.tintColor = self.registerBtn.tintColor
                self.loginBtn.backgroundColor = self.registerBtn.backgroundColor
            })
        }
    }
    
    
    func conformFeildHidden(){
        view.removeConstraint(conformCenter)
        conformLeft.constant -= 500
        loginBtnTop.constant -= 60
        registerBtnTop.constant -= 60
    }
    
    func conformFeildShow(){
        view.addConstraint(conformCenter)
        conformLeft.constant += 500
        loginBtnTop.constant += 60
        registerBtnTop.constant += 60
    }
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension LoginViewController {
    
    func addMMSpinner(superView: UIView){
        
        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 2.0
        ovalShapeLayer.frame = CGRectMake(0, 0, superView.frame.width, superView.frame.height)
        //        ovalShapeLayer.backgroundColor = UIColor.orangeColor().CGColor
        let refreshRadius = superView.frame.size.height/2 * 0.5
        let path = UIBezierPath(ovalInRect: CGRect(
            x: superView.frame.size.width/2 - refreshRadius,
            y: superView.frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius))
        
        ovalShapeLayer.path = path.CGPath
        
        superView.layer.addSublayer(ovalShapeLayer)
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
