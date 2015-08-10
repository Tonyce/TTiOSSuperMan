//
//  SupermanCell.swift
//  superman
//
//  Created by D_ttang on 15/8/10.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SupermanCell: UITableViewCell {

    @IBOutlet weak var goodHeartBtn: UIButton!
    @IBOutlet weak var supermainImage: UIImageView!
    @IBOutlet weak var supermanNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        supermainImage.layer.cornerRadius = CGRectGetHeight(supermainImage.frame) / 2
        supermainImage.layer.masksToBounds = true
        
        goodHeartBtn.setTitle( GoogleIcon.e65a, forState:UIControlState.Normal)
        goodHeartBtn.tintColor = UIColor.redColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func heartAction(sender: AnyObject) {
        print("----")
    }
}
