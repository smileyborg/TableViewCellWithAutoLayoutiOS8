//
//  RJCell.h
//  TableViewController
//
//  Created by Kevin Muldoon on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//

#import <UIKit/UIKit.h>

// Need this value accessible in the view controller to set the correct preferredMaxLayoutWidth on the bodyLabel.
#define kLabelHorizontalInsets  20.0f

@interface RJTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

@end
