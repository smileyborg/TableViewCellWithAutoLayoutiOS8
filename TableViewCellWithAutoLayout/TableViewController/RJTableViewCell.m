//
//  RJCell.m
//  TableViewController
//
//  Created by Kevin Muldoon on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//

#import "RJTableViewCell.h"

@interface RJTableViewCell ()

// We'll set this to YES once this instance of the cell has setup its constraints, so that any additional calls to updateConstraints are no-ops
@property (nonatomic, assign) BOOL hasSetupConstraints;

@end

@implementation RJTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setFont: [UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
//        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
//        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];

        self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        
        // You don't want the below line; let the font size for the multi-line body label remain fixed.
//        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setFont: [UIFont fontWithName:@"Helvetica" size:14]];
        [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
        [self.bodyLabel setBackgroundColor:[UIColor clearColor]];
        
        // If you don't do this, the auto layout solver engine may calculate a ever-so-slightly smaller height than actually required
        // (probably due to rounding errors internally) which will cause the bodyLabel to truncate the last line. This will force
        // the bodyLabel to always get the size it needs for all the lines. (The titleLabel height will be reduced ever so slightly
        // in this case if needed to satisfy this constraint, but in this case it shouldn't be noticeable.)
        // Another way to solve this is to return a slightly larger cell height (add 1 point) than the auto layout calculations return.
        // Or a third way is to build in a few points of padding (perhaps between the labels, or above or below them) which has a priority of
        // UILayoutPriorityDefaultHigh - 1, so that it will be the first thing to be reduced if the cell height is a tiny bit too small -
        // it will act as a buffer to prevent the labels from getting smaller than the size they really want.
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

        // Add your subviews right away during init - no reason to wait until later
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.bodyLabel];
    }
    
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    // Modified to a single-line return. No biggie.
    //
    if (self.hasSetupConstraints) return;

    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.titleLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeLeading
                                     multiplier:1.0f
                                     constant:kLabelHorizontalInsets]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.titleLabel
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTop
                                     multiplier:1.0f
                                     constant:(kLabelHorizontalInsets / 2)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:self.titleLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                     attribute:NSLayoutAttributeTrailing
                                     multiplier:1.0f
                                     constant:-kLabelHorizontalInsets]];
    
    // You don't need the below constraint - the auto-generated content compression resistance constraints on UILabel are sufficient!
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.titleLabel
//                                      attribute:NSLayoutAttributeHeight
//                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
//                                      toItem:nil
//                                      attribute:NSLayoutAttributeNotAnAttribute
//                                      multiplier:1.0f
//                                      constant:22.0f]];
    
    // "You don't need the below constraint - the auto-generated content compression resistance constraints on UILabel are sufficient!"
    //
    // OK, this is weird. Without NSLayoutAttributeHeight-NSLayoutRelationGreaterThanOrEqual self.titleLabel collapses?
    // Adding the NSLayoutAttributeHeight-NSLayoutRelationGreaterThanOrEqual resolves issue. Perhaps there is another way...
    // ...
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.titleLabel
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                      toItem:nil
                                      attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1.0f
                                      constant:22.0f]];
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeLeading
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeLeading
                                      multiplier:1.0f
                                      constant:kLabelHorizontalInsets]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.titleLabel
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:(kLabelHorizontalInsets / 4)]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeTrailing
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeTrailing
                                      multiplier:1.0f
                                      constant:-kLabelHorizontalInsets]];
    
    [self.contentView  addConstraint:[NSLayoutConstraint
                                      constraintWithItem:self.bodyLabel
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.contentView
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:-(kLabelHorizontalInsets / 2)]];
    
    // You don't need the below constraint - the auto-generated content compression resistance constraints on UILabel are sufficient!
//    [self.contentView  addConstraint:[NSLayoutConstraint
//                                      constraintWithItem:self.bodyLabel
//                                      attribute:NSLayoutAttributeHeight
//                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
//                                      toItem:nil
//                                      attribute:NSLayoutAttributeNotAnAttribute
//                                      multiplier:1.0f
//                                      constant:22.0f]];
    
    self.hasSetupConstraints = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
