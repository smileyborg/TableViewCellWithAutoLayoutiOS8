//
//  TableViewCell.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Tyler Fox
//

import UIKit
import PureLayout

class TableViewCell: UITableViewCell
{
    // The CGFloat type annotation is necessary for these constants because they are passed as arguments to bridged Objective-C methods,
    // and without making the type explicit these will be inferred to be type Double which is not compatible.
    let kLabelHorizontalInsets: CGFloat = 15.0
    let kLabelVerticalInsets: CGFloat = 10.0
    
    var didSetupConstraints = false
    
    var titleLabel: UILabel = UILabel.newAutoLayout()
    var bodyLabel: UILabel = UILabel.newAutoLayout()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    func setupViews()
    {
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.1) // light blue
        
        bodyLabel.lineBreakMode = .byTruncatingTail
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .left
        bodyLabel.textColor = UIColor.darkGray
        bodyLabel.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1) // light red
        
        updateFonts()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        
        contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1) // light green
    }
    
    override func updateConstraints()
    {
        if !didSetupConstraints {
            // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
            // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
            //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
            // contentView.bounds = CGRect(x: 0.0, y: 0.0, width: 99999.0, height: 99999.0)
            
            // Prevent the two UILabels from being compressed below their intrinsic content height
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityRequired) {
                self.titleLabel.autoSetContentCompressionResistancePriority(for: .vertical)
                self.bodyLabel.autoSetContentCompressionResistancePriority(for: .vertical)
            }
            
            titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: kLabelVerticalInsets)
            titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: kLabelHorizontalInsets)
            titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: kLabelHorizontalInsets)
            
            // This constraint is an inequality so that if the cell is slightly taller than actually required, extra space will go here
            bodyLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10.0, relation: .greaterThanOrEqual)
            
            bodyLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: kLabelHorizontalInsets)
            bodyLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: kLabelHorizontalInsets)
            bodyLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: kLabelVerticalInsets)
            
            didSetupConstraints = true
        }
    
        super.updateConstraints()
    }
    
    func updateFonts()
    {
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
    }
}
