//
//  loginLogoutCell.swift
//  superman
//
//  Created by D_ttang on 15/7/31.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class LoginLogoutCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imgLabel: UILabel!
    
    var entry: [String: Bool]! {
        didSet {
            configureCell()
        }
    }
    
    func configureCell(){
        if entry["logined"] == false {
            imgLabel.font = UIFont(name: GoogleIconName, size: 20.0)
            imgLabel.textColor = UIColor.MKColor.LightBlue
            imgLabel.text = GoogleIcon.e83b
            
            wordLabel.text = "登陆/注册账号"
        }else {
            imgLabel.font = UIFont(name: GoogleIconName, size: 20.0)
            imgLabel.textColor = UIColor.redColor()
            imgLabel.text = GoogleIcon.e839
            
            wordLabel.text = "退出账号"
            wordLabel.tintColor = UIColor.redColor()
        }
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
