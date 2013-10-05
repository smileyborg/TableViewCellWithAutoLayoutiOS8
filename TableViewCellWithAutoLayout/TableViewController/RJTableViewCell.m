//
//  RJCell.m
//  TableViewController
//
//  Created by Kevin Muldoon on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//

#import "RJTableViewCell.h"

@implementation RJTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.titleLabel setNumberOfLines:1];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setFont: [UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setBackgroundColor:[UIColor lightGrayColor]];

        self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        [self.bodyLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self.bodyLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setAdjustsFontSizeToFitWidth:YES];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setFont: [UIFont fontWithName:@"Helvetica" size:11]];
        [self.bodyLabel setTextColor:[UIColor blackColor]];
        [self.bodyLabel setBackgroundColor:[UIColor yellowColor]];
        
    }
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bodyLabel];

    [self layoutSubviews];
    [self updateConstraints];
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

}

- (void)updateConstraints {
    [super updateConstraints];

    [self.contentView addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.titleLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationLessThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1.0f
                         constant:22.0f]];
    
    ///////////////////////////////////////////////////////////////////////////////////////////

    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.bodyLabel
                         attribute:NSLayoutAttributeLeading
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeLeading
                         multiplier:1.0f
                         constant:20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.bodyLabel
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.titleLabel
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:0.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.bodyLabel
                         attribute:NSLayoutAttributeTrailing
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeTrailing
                         multiplier:1.0f
                         constant:-20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.bodyLabel
                         attribute:NSLayoutAttributeBottom
                         relatedBy:NSLayoutRelationEqual
                         toItem:self.contentView
                         attribute:NSLayoutAttributeBottom
                         multiplier:1.0f
                         constant:-20.0f]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.bodyLabel
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:nil
                         attribute:NSLayoutAttributeNotAnAttribute
                         multiplier:1.0f
                         constant:22.0f]];
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
