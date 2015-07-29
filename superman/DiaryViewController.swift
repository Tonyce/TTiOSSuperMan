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
    @IBOutlet weak var selectColorBtn: UIButton!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var editBtnTop: NSLayoutConstraint!
    
    var keyboardRect = CGRectZero
    var wordTextView: UITextView!
    var contentSuperView: UIScrollView!
    let contentSuperViewDefaultContentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    var defaultContentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    var keyBoardRect: CGRect!
    
    var isDiaryEditing = false
    var isFromAdd = false
    var topViewColorEntry = Colors.colorArr[0]
    
    var diaryEntry: DiaryEntry?
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewContainer.contentSize = CGSize(width: view.bounds.width, height:  view.bounds.height + 10 )
        
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
        markLabel.text = "发生的，经历的..."
        
        if let diaryEntry = self.diaryEntry {
            topViewColorEntry = Colors.colorArr[ diaryEntry.colorEntryIndex! ]
            textView.text = diaryEntry.content
        }
        
        topView.backgroundColor = topViewColorEntry["color"] as? UIColor
        textViewHeight.constant = textView.contentSize.height
        // textView.frame.size.height = textView.contentSize.height
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
    
    @IBAction func saveAction(sender: UIButton){
        saveDiary()
    }

    @IBAction func editAction(sender: UIButton) {
        // print(self.markLabel.center)
        isDiaryEditing = true

        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.editBtn.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI) / 4)
                self.editBtn.alpha = 0.0
                self.doneBtn.alpha = 1.0
                
                
                self.markLabel.text = "2015-07-25 周六"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "setDiaryColorSegue" {
            let setColorView = segue.destinationViewController as! SelectColorViewController
            setColorView.delegate = self
            setColorView.nowColorEntry = topViewColorEntry
        }
        
        if segue.identifier == "unwindToDiary" {
            self.diaryEntry?.content = self.textView.text
        }
    }

}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(textView: UITextView) {

    }
    
    func textViewDidChange(textView: UITextView) {
        // let textHeight = CGFloat(textViewHeight)
        if textView.contentSize.height > textViewHeight.constant {
            textViewHeight.constant = textView.contentSize.height
            scrollViewContainer.contentSize.height = view.bounds.height + textView.contentSize.height

            self.view.layoutIfNeeded()
        }

    }
}

extension DiaryViewController {
    func handleKeyboardDidShow (notification: NSNotification){
        
        /* Get the frame of the keyboard */
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        /* Place it in a CGRect */
        
        
        keyboardRectAsObject.getValue(&keyboardRect)
        
//        self.scrollView setContentOffset:CGPointMake(0, kbSize.height) animated:YES
//        self.scrollViewContainer.setContentOffset(CGPointMake(0, keyboardRect.height), animated: true)
        
//        let contentInsets = UIEdgeInsetsMake(defaultContentInset.top, defaultContentInset.left,keyboardRect.height, defaultContentInset.right)
//        textView.contentInset = contentInsets
        
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


//            print(textView.contentSize)
//                contentSuperView.scrollRectToVisible(wordTextView.frame, animated: true)

//        print(wordTextView.contentSize.height)
//        wordTextView.frame.size.height = wordTextView.contentSize.height
//
//        contentSuperView.contentSize = wordTextView.bounds.size
//        contentSuperView.scrollRectToVisible( CGRectMake(wordTextView.frame.origin.x, wordTextView.frame.origin.y + wordTextView.frame.size.height, wordTextView.frame.size.width, 10), animated: true)

//        contentSuperView.setContentOffset(CGPointMake(0.0, wordTextView.frame.origin.y - keyBoardRect.height), animated: true)


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
