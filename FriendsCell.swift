//
//  FriendsCell.swift
//  superman
//
//  Created by D_ttang on 15/8/6.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {

    @IBOutlet weak var imgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgLabel.font = UIFont(name: GoogleIconName, size: 20.0)
        imgLabel.textColor = UIColor.MKColor.Indigo
        imgLabel.text = GoogleIcon.ea3d
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
