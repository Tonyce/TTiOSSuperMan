//
//  AddDiaryViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    var wordTextView: UITextView!
    var contentSuperView: UIScrollView!
    let contentSuperViewDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    var defaultContentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    var keyBoardRect: CGRect!
    
    var isDiaryEditing = false
    var isFromAdd = false
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCloseBtn()
        initDoneBtn()
        initEditBtn()
        
        contentSuperView = UIScrollView(frame: CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.height - 60))
        contentSuperView.backgroundColor = UIColor.brownColor()
        contentSuperView.contentInset = contentSuperViewDefaultContentInset
        
        wordTextView = UITextView(frame: CGRectMake(10, 300, contentSuperView.frame.size.width - 25, 50))
        defaultContentInset = textView.contentInset
        textView.font = UIFont.systemFontOfSize(16)
        textView.userInteractionEnabled = false
        textView.delegate = self
        

        // self.view.insertSubview(contentSuperView, belowSubview: topView)
        self.markLabel.center.y = 60
        
        
        // MARK: Keyboard handle
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "handleKeyboardDidShow:",
            name: UIKeyboardDidShowNotification,
            object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initCloseBtn(){
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(editBtn.frame) / 2
    }
    
    func initDoneBtn(){
        doneBtn.setTitle(GoogleIcon.e649, forState: UIControlState.Normal)
        doneBtn.tintColor = UIColor.whiteColor()
        doneBtn.layer.cornerRadius = CGRectGetHeight(editBtn.frame) / 2
        if isFromAdd {
            doneBtn.alpha = 1.0
        }else {
            doneBtn.alpha = 0.0
        }

    }
    
    func initEditBtn(){
        editBtn.setTitle(GoogleIcon.e818, forState: UIControlState.Normal)
        editBtn.tintColor = UIColor.whiteColor()
        editBtn.layer.cornerRadius = CGRectGetHeight(editBtn.frame) / 2
        
        editBtn.layer.shadowOpacity = 0.5
        editBtn.layer.shadowOffset  = CGSize(width: 0, height: 1.5)
        editBtn.layer.shadowColor   = UIColor.blackColor().CGColor
        
        if isFromAdd {
            editBtn.alpha = 0.0
        }else {
            editBtn.alpha = 1.0
        }
    }
    
    @IBAction func closeAction(sender: UIButton){
        if isDiaryEditing {
            saveDiary()
        }else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func editAction(sender: UIButton) {
        // print(self.markLabel.center)
        isDiaryEditing = true

        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.editBtn.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI) / 4)
                self.editBtn.alpha = 0.0
                self.doneBtn.alpha = 1.0
//                self.topView.bounds.size.height = 60
//                self.topView.center.y = 30
//                self.editBtn.center.y = 60
//                self.markLabel.center.y = 40
            }, completion: {
                _ in
                self.textView.userInteractionEnabled = true
                self.textView.becomeFirstResponder()
        })
    }
    
    @IBAction func doneAction(sender: UIButton) {
        saveDiary()
    }
    
    func saveDiary(){
        
        self.textView.resignFirstResponder()
        self.textView.userInteractionEnabled = false
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.editBtn.transform = CGAffineTransformMakeRotation(CGFloat(0))
                self.editBtn.alpha = 1.0
                self.doneBtn.alpha = 0.0
                
                self.topView.bounds.size.height = 80
                self.topView.center.y = 40
                self.editBtn.center.y = 80
                self.markLabel.center.y = 60
            }, completion: {
                _ in
                self.isDiaryEditing = false
        })
    }
   

}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {
//            print(textView.contentSize)
//                contentSuperView.scrollRectToVisible(wordTextView.frame, animated: true)
    }
    
    func textViewDidChange(textView: UITextView) {
//        print(wordTextView.contentSize.height)
//        wordTextView.frame.size.height = wordTextView.contentSize.height
//
//        contentSuperView.contentSize = wordTextView.bounds.size
//        contentSuperView.scrollRectToVisible( CGRectMake(wordTextView.frame.origin.x, wordTextView.frame.origin.y + wordTextView.frame.size.height, wordTextView.frame.size.width, 10), animated: true)
        
//        contentSuperView.setContentOffset(CGPointMake(0.0, wordTextView.frame.origin.y - keyBoardRect.height), animated: true)
        
    }
}

extension DiaryViewController {
    func handleKeyboardDidShow (notification: NSNotification){
        
        /* Get the frame of the keyboard */
        let keyboardRectAsObject =
        notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        /* Place it in a CGRect */
        var keyboardRect = CGRectZero
        
        keyboardRectAsObject.getValue(&keyboardRect)
        
        let contentInsets = UIEdgeInsetsMake(defaultContentInset.top, defaultContentInset.left,keyboardRect.height, defaultContentInset.right)
        textView.contentInset = contentInsets
//        contentSuperView.contentInset =  contentInsets
        
//        keyBoardRect = keyboardRect
//        var aRect:CGRect  = self.view.frame
//        aRect.size.height -= (keyboardRect.height + aRect.origin.y)
        
//        let point = CGPointMake(wordTextView.frame.origin.x, wordTextView.frame.origin.y + 180)
        
//        if !CGRectContainsPoint(aRect, point)  {
//            print("no contains")
//             contentSuperView.setContentOffset(CGPointMake(0.0, wordTextView.frame.origin.y - keyboardRect.height), animated: true)
//            contentSuperView.scrollRectToVisible(CGRectMake(wordTextView.frame.origin.x, wordTextView.frame.origin.y + 180, wordTextView.frame.size.width, wordTextView.frame.size.height), animated: true)
//        }
        
    }
    
    func handleKeyboardWillHide(notification: NSNotification){
        textView.contentInset = defaultContentInset
    }
    
}
