//
//  NibTableViewCell.swift
//  TableViewCellWithAutoLayout
//
//  Created by Morten Bøgh on 09/06/14.
//  Copyright (c) 2014 RobotJackalope. All rights reserved.
//

import UIKit

class NibTableViewCell: UITableViewCell
{
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var bodyLabel : UILabel
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        updateFonts()
    }
    
    func updateFonts()
    {
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        bodyLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
    }
}
