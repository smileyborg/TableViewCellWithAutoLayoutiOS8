//
//  TableViewCell.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Tyler Fox
//

import UIKit

class TableViewCell: UITableViewCell
{
    let labelHorizontalInsets = 15.0
    let labelVerticalInsets = 10.0
    
    var didSetupConstraints = false
    
    var titleLabel: UILabel
    var bodyLabel: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        titleLabel = UILabel.newAutoLayoutView()
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .Left
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.1) // light blue
        
        bodyLabel = UILabel.newAutoLayoutView()
        bodyLabel.lineBreakMode = .ByTruncatingTail
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .Left
        bodyLabel.textColor = UIColor.darkGrayColor()
        bodyLabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1) // light red
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1) // light red
        
        updateFonts()
    }
    
    override func updateConstraints()
    {
        super.updateConstraints()
        
        if didSetupConstraints {
            return
        }
        
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        // contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)
        
        UIView.autoSetPriority(1000) {
            self.titleLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
        }
        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: labelVerticalInsets)
        titleLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: labelHorizontalInsets)
        titleLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: labelHorizontalInsets)

        bodyLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: labelVerticalInsets)

        UIView.autoSetPriority(1000) {
            self.bodyLabel.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
        }
        bodyLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: labelHorizontalInsets)
        bodyLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: labelHorizontalInsets)
        bodyLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: labelVerticalInsets)
        
        didSetupConstraints = true
    }
    
    func updateFonts()
    {
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        bodyLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)
    }
}
