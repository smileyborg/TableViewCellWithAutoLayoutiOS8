//
//  AddNewCell.swift
//  TableViewCellWithAutoLayout
//
//  Created by Charlie Bartel on 12/30/14.
//  Copyright (c) 2014 RobotJackalope. All rights reserved.
//

import UIKit

class OffSetLabel: UILabel {
    
    var offset: CGFloat = 10.0
    
    override func drawTextInRect(rect: CGRect) {
        let newRect = CGRectOffset(rect, offset, 0)
        super.drawTextInRect(newRect)
    }
}

class AddNewCell: UICollectionViewCell {
    
    enum AddCellType {
        case Vertical
        case Horizontal
    }
    
    var horizontalInsets: CGFloat = 16.0
    let verticalInsets: CGFloat = 2.0
    let imageSize: CGFloat = 42.0
    
    var didSetupConstraints = false
    
    var titleLabel: OffSetLabel = OffSetLabel.newAutoLayoutView()
    var titleLayoutConstraint : NSLayoutConstraint? = nil
    
    var imageView: UIImageView = UIImageView.newAutoLayoutView()
    var imageLayoutConstraint : NSLayoutConstraint? = nil
    
    var cellType: AddCellType = .Vertical
    var containerBackgroundColor: UIColor = UIColor.brownColor()
    var titleBackgroundColor: UIColor = UIColor.clearColor()
    
    // --------------------------------------------------------------------------------
    // MARK: -
    // MARK: NSObject Methods
    // --------------------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // --------------------------------------------------------------------------------
    // MARK: -
    // MARK: UIView Methods
    // --------------------------------------------------------------------------------
    
    override func updateConstraints() {
        if !didSetupConstraints {
            
            if (cellType == .Vertical) {
                imageView.autoPinEdgeToSuperviewEdge(.Top, withInset: verticalInsets)
                imageView.autoSetDimension(.Height, toSize: imageSize)
                imageView.autoSetDimension(.Width, toSize: imageSize)
                imageView.autoAlignAxisToSuperviewAxis(.Vertical)
            
                titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView, withOffset: 0, relation: .Equal)
                titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
                titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
                titleLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
                
            } else {
                
                imageView.autoSetDimension(.Height, toSize: imageSize)
                imageView.autoSetDimension(.Width, toSize: imageSize)
                imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
                
                titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 0, relation: .Equal)
                titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
                titleLabel.autoSetDimension(.Height, toSize: imageSize)
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // --------------------------------------------------------------------------------
    // MARK: -
    // MARK: UICollectionViewCell Methods
    // --------------------------------------------------------------------------------
    
    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                contentView.backgroundColor = (cellType == .Vertical) ? UIColor.darkGrayColor() : UIColor.clearColor()
                titleLabel.backgroundColor = (cellType == .Vertical) ? titleBackgroundColor : UIColor.darkGrayColor()
                titleLabel.textColor = UIColor.whiteColor()
            } else {
                contentView.backgroundColor = containerBackgroundColor
                titleLabel.backgroundColor = (cellType == .Vertical) ? titleBackgroundColor : UIColor.grayColor()
                titleLabel.textColor = UIColor.blackColor()
            }
            
        }
    }
    
    // --------------------------------------------------------------------------------
    // MARK: -
    // MARK: Private Methods
    // --------------------------------------------------------------------------------
    
    func setupViews() {
        titleLabel.lineBreakMode = .ByTruncatingTail
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.backgroundColor = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = containerBackgroundColor
    }
    
    // --------------------------------------------------------------------------------
    // MARK: -
    // MARK: Public Methods
    // --------------------------------------------------------------------------------
    
    func updateCell(type: AddCellType) {
        cellType = type
        if (cellType == .Vertical) {
            titleLabel.offset = 0;
            titleLabel.textAlignment = .Center
            titleLabel.backgroundColor = titleBackgroundColor
        } else {
            
            println("updateCell horizontalInsets \(horizontalInsets)");
            
            // The horizontalInsets change on rotation so update the constraint as needed
            imageLayoutConstraint?.active = false
            imageLayoutConstraint = imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: horizontalInsets)
            
            titleLayoutConstraint?.active = false
            titleLayoutConstraint = titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: horizontalInsets)
            
            titleLabel.offset = 10.0;
            titleLabel.textAlignment = .Left
            titleLabel.backgroundColor = UIColor.grayColor()
        }
        
        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
    }
}

