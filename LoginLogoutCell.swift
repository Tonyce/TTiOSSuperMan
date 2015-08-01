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
    
    var entry: [String: Int]! {
        didSet {
            configureCell()
        }
    }
    
    func configureCell(){
        if entry["login"] == 0 {
            imgLabel.font = UIFont(name: GoogleIconName, size: 18.0)
            imgLabel.textColor = UIColor.MKColor.LightBlue
            imgLabel.text = GoogleIcon.e83b
            
            wordLabel.text = "登陆账号"
//        }else if entry["login"] == 1 {
//            imgLabel.font = UIFont(name: GoogleIconName, size: 18.0)
//            imgLabel.textColor = UIColor.MKColor.LightBlue
//            imgLabel.text = GoogleIcon.e83b
//            
//            wordLabel.text = "已登陆"
        }else {
            imgLabel.font = UIFont(name: GoogleIconName, size: 18.0)
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
