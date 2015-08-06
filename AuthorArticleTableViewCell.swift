//
//  AuthorArticleTableViewCell.swift
//  superman
//
//  Created by D_ttang on 15/7/30.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class AuthorArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    var entry: [String: AnyObject]! {
        didSet {
            configureCell()
        }
    }
    // MARK: - Utility methods
    private func configureCell() {
        imageLabel.font = UIFont(name: GoogleIconName, size: 20.0)
        let colorIndex = entry["colorIndex"] as! Int
        imageLabel.textColor = Colors.colorArr[colorIndex]["color"] as! UIColor
        
        imageLabel.text = entry["img"] as? String
        
        wordLabel.text = entry["word"] as? String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        self.superview.willLoadUrl = entry["href"] as String
        // Configure the view for the selected state
    }

}
