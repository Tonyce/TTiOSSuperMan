//
//  SettingViewColorCell.swift
//  superman
//
//  Created by D_ttang on 15/7/17.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SettingViewColorCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var colorEntry: [String: AnyObject]! {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        colorLabel.font = UIFont(name: GoogleIconName, size: 18.0)
        colorLabel.textColor = colorEntry["color"] as! UIColor
        colorLabel.text = GoogleIcon.eacd
        
        colorNameLabel.text = colorEntry["name"] as? String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
