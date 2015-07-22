//
//  meCellTableViewCell.swift
//  superman
//
//  Created by D_ttang on 15/7/13.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class meTableViewCell: UITableViewCell {

    @IBOutlet weak var selfImage: UIImageView!
    
    @IBOutlet weak var wordView: UITextView!
    
    var selfConfig: SelfConfig! {
        didSet {
            configureCell()
        }
    }
    // MARK: - Utility methods
    private func configureCell() {
        selfImage.image = selfConfig?.image
//        wordTextView.text = selfConfig?.word
//        wordView.text = "路漫漫其修远兮\n吾将上下而求索"
        wordView.text = selfConfig?.word
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selfImage.layer.cornerRadius = CGRectGetHeight(self.selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
