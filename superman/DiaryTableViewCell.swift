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
    @IBOutlet weak var labelField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        print(labelField.frame)
        labelField.layer.cornerRadius = CGRectGetHeight(self.labelField.frame) / 2
        labelField.layer.masksToBounds = true
//        labelField.layer.backgroundColor = UIColor.redColor().CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
