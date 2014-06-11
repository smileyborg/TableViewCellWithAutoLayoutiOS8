//
//  NibTableViewCell.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Morten Bøgh
//

import UIKit

class NibTableViewCell: UITableViewCell
{
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var bodyLabel: UILabel
    
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
