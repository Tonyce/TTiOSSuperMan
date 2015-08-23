//
//  AddDiaryViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/9.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    
    @IBOutlet weak var scrollViewContainer: UIScrollView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editBtnTop: NSLayoutConstraint!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var keyboardRect = CGRectZero
    let contentSuperViewDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    
    var defaultContentInset = UIEdgeInsets()
    var keyBoardRect: CGRect!
    
    var isDiaryEditing = false
    var isFromAdd = false
    var topViewColorEntry = Colors.colorArr[0]
    
    var diaryEntry: Diary?
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCloseBtn()
        initDoneBtn()
        initEditBtn()
        
        defaultContentInset = textView.contentInset
        
        textView.userInteractionEnabled = false
        textView.delegate = self
    
        colorView.layer.borderColor = UIColor.MKColor.BlueGrey.CGColor
        colorView.layer.borderWidth = 0.3
        
        colorLabel.font = UIFont(name: GoogleIconName, size: 18.0)
        colorLabel.text = GoogleIcon.eacd
        
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
    
    override func viewWillAppear(animated: Bool) {
        markLabel.text = ""
        
        if let diaryEntry = self.diaryEntry {
            topViewColorEntry = Colors.colorArr[ diaryEntry.colorEntryIndex as! Int ]
            textView.text = diaryEntry.content
            markLabel.text = diaryEntry.time
        }
        
        topView.backgroundColor = topViewColorEntry["color"] as? UIColor
        colorLabel.textColor =  topViewColorEntry["color"] as? UIColor
        colorNameLabel.text = topViewColorEntry["name"] as? String

        if textView.contentSize.height > textViewHeight.constant {
            textViewHeight.constant = textView.contentSize.height + 30
        }
        // textView.frame.size.height = textView.contentSize.height
        scrollViewContainer.contentSize.height = view.bounds.height + textView.contentSize.height
        self.view.layoutIfNeeded()

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

    @IBAction func editAction(sender: UIButton) {
        // print(self.markLabel.center)
        isDiaryEditing = true

        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.editBtn.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI) / 4)
                self.editBtn.alpha = 0.0
                self.doneBtn.alpha = 1.0
                
                self.editBtnTop.constant -= 15
                self.topViewHeight.constant = 70
                self.view.layoutIfNeeded()
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
        
        self.diaryEntry?.content = self.textView.text
        self.textView.resignFirstResponder()
        self.textView.userInteractionEnabled = false
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.editBtn.transform = CGAffineTransformMakeRotation(CGFloat(0))
                self.editBtn.alpha = 1.0
                self.doneBtn.alpha = 0.0
                
                self.editBtnTop.constant += 15
                self.topViewHeight.constant = 80
                self.view.layoutIfNeeded()
            }, completion: {
                _ in
                self.isDiaryEditing = false
        })
    }
    
    @IBAction func selectColor(sender: UITapGestureRecognizer) {
        let colorSelectView = storyboard?.instantiateViewControllerWithIdentifier("selectColorView") as! SelectColorViewController
        colorSelectView.delegate = self
        colorSelectView.nowColorEntry = topViewColorEntry
        presentViewController(colorSelectView, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToDiary" {

        }
    }

}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {

    }
    
    func textViewDidChange(textView: UITextView) {
            textViewHeight.constant = textView.contentSize.height
            scrollViewContainer.contentSize.height = view.bounds.height + textView.contentSize.height

            self.view.layoutIfNeeded()

    }
}

extension DiaryViewController {
    func handleKeyboardDidShow (notification: NSNotification){
        
        /* Get the frame of the keyboard */
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        /* Place it in a CGRect */
        
        
        keyboardRectAsObject.getValue(&keyboardRect)

        
    }
    
    func handleKeyboardWillHide(notification: NSNotification){
        
        keyboardRect = CGRectZero
        
        textView.contentInset = defaultContentInset
    }
    
}

extension DiaryViewController : SelectColorViewControllerDelegate {
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String : AnyObject], colorIndex index: Int) {
        topViewColorEntry = colorEntry
        // topView.backgroundColor = colorEntry["color"] as? UIColor
        diaryEntry?.colorEntryIndex = index
        dismissViewControllerAnimated(true, completion: nil)
    }
}

