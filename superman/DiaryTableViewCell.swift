//
//  DiaryTableViewCell.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {

    @IBOutlet weak var circleIdentifyLabel: UILabel!
    @IBOutlet weak var weatherField: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellText: UITextView!
    
    var diaryEntry: Diary! {
        didSet {
            configureCell()
        }
    }
    // MARK: - Utility methods
    private func configureCell() {
        self.weatherField.text = diaryEntry.time
        
//        self.weatherField.textColor = diaryEntry.color
//        self.timeLabel.textColor = diaryEntry.color
        
        self.circleIdentifyLabel.font = UIFont(name: GoogleIconName, size: 15.0)
//        let index:Int = diaryEntry.colorEntryIndex s
        var colorEntry = Colors.colorArr[ diaryEntry.colorEntryIndex as! Int] as [String: AnyObject]
        self.circleIdentifyLabel.textColor = colorEntry["color"] as! UIColor
        self.circleIdentifyLabel.text = GoogleIcon.eacd
        
        self.cellText.text = diaryEntry.content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        labelField.layer.cornerRadius = CGRectGetHeight(self.labelField.frame) / 2
//        labelField.layer.masksToBounds = true
//        labelField.backgroundColor = UIColor.clearColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
