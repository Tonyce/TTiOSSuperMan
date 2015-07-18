//
//  ColorViewCell.swift
//  superman
//
//  Created by D_ttang on 15/7/17.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ColorViewCell: UITableViewCell {

    @IBOutlet weak var colorCircleLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
//    var colorEntry: [String: AnyObject]!
    var systemColorEntry = SystemConfig.sharedInstance.systemColorEntry
    
    // MARK: - Properties
    var colorEntry: [String: AnyObject]! {
        didSet {
            configureCell()
        }
    }
    // MARK: - Utility methods
    private func configureCell() {
        colorCircleLabel.font = UIFont(name: GoogleIconName, size: 18.0)
        colorCircleLabel.textColor = colorEntry["color"] as! UIColor
        colorCircleLabel.text = GoogleIcon.eaed
            
        colorNameLabel.text = colorEntry["name"] as? String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellBackView = UIView(frame: self.frame)
        self.selectedBackgroundView = cellBackView
        self.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
//        self.backgroundView = UIView(frame: CGRect)
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if selected {
//            colorCircleLabel.text = GoogleIcon.eacd
//            self.accessoryType = UITableViewCellAccessoryType.Checkmark
//        }
//        // Configure the view for the selected state
//    }
    
    
}
