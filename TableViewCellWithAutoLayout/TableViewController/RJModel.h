//
//  RJSimpleModel.h
//  Collection
//
//  Created by Kevin Muldoon on 5/4/13.
//  Copyright (c) 2013 Kevin Muldoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;

- (void)populateDataSource;

@end
