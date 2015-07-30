//
//  AddDiaryViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/24.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class AddDiaryViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var diaryEntryContainer: (time:String, content: String, colorEntryIndex: Int)?
    var defaultColorEntry: [String: AnyObject]!
    var colorEntryIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultColorEntry = Colors.colorArr[0]
        
        
        
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        
        saveBtn.setTitle(GoogleIcon.e649, forState: UIControlState.Normal)
        saveBtn.tintColor = UIColor.whiteColor()
        saveBtn.layer.cornerRadius = CGRectGetHeight(saveBtn.frame) / 2

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        textView.becomeFirstResponder()

        colorLabel.font = UIFont(name: GoogleIconName, size: 15.0)
        colorLabel.textColor = defaultColorEntry["color"] as! UIColor
        colorLabel.text = GoogleIcon.eacd
        
        colorNameLabel.text = defaultColorEntry["name"] as? String
        
        topView.backgroundColor = defaultColorEntry["color"] as? UIColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addDiary" {
            let dateFormatter = NSDateFormatter()
            let now = NSDate()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            // Date 转 String
            let nowString = dateFormatter.stringFromDate(now)
            
            let week = getDayOfWeek(now)
            
//            self.diaryEntry = DiaryEntry(time: nowString + " " + week, content: textView.text, colorEntryIndex: colorEntryIndex)
            self.diaryEntryContainer = (time: nowString + " " + week, content: textView.text, colorEntryIndex: colorEntryIndex)
//            self.diaryEntryContainer?.time = nowString + " " + week
//            self.diaryEntryContainer?.content = textView.text
//            self.diaryEntryContainer?.colorEntryIndex = colorEntryIndex
        }
    }

    @IBAction func showColorSelectView(sender: AnyObject) {
        let colorSelectView = storyboard?.instantiateViewControllerWithIdentifier("selectColorView") as! SelectColorViewController
        colorSelectView.delegate = self
        colorSelectView.nowColorEntry = defaultColorEntry
        presentViewController(colorSelectView, animated: true, completion: nil)
    }
    
    func getDayOfWeek(today:NSDate)->String{
        var weekth = ""
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(NSCalendarUnit.Weekday, fromDate: today)
        let weekDay = myComponents.weekday - 1
        switch weekDay {
        case 0:
            weekth = "天"
        case 1:
            weekth = "一"
        case 2:
            weekth = "二"
        case 3:
            weekth = "三"
        case 4:
            weekth = "四"
        case 5:
            weekth = "五"
        case 6:
            weekth = "六"
        default:
            weekth = ""
        }
        return "星期" + weekth
    }
}

extension AddDiaryViewController : SelectColorViewControllerDelegate {
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String : AnyObject], colorIndex index: Int) {

        defaultColorEntry = colorEntry
        colorEntryIndex = index
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
