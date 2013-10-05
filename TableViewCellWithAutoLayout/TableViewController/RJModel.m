//
//  RJSimpleModel.m
//  Collection
//
//  Created by Kevin Muldoon on 5/4/13.
//  Copyright (c) 2013 Kevin Muldoon. All rights reserved.
//

#import "RJModel.h"

@implementation RJModel

- (id)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)populateDataSource {
    
    NSArray *fontFamilies = [NSArray arrayWithArray:[UIFont familyNames]];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[fontFamilies count]];

    for ( NSString *familyName in fontFamilies ) {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:familyName, @"title",
                                    [self randomLorumIpsum], @"body",
                                    @"", @"element2",
                                    @"", @"element3",
                                    @"", @"element4",
                                    nil];
        [result addObject:dictionary];
    }
    
    self.dataSource = [NSArray arrayWithArray:result];
    
}

- (NSString *)randomLorumIpsum {
    NSString *result;
    
    NSString *lorumIpsum = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum. Cras eleifend lacus eget pharetra elementum. Etiam fermentum eu felis eu tristique. Integer eu purus vitae turpis blandit consectetur. Nulla facilisi. Praesent bibendum massa eu metus pulvinar, quis tristique nunc commodo. Ut varius aliquam elit, a tincidunt elit aliquam non. Nunc ac leo purus. Proin condimentum placerat ligula, at tristique neque scelerisque ut. Suspendisse ut congue enim. Integer id sem nisl. Nam dignissim, lectus et dictum sollicitudin, libero augue ullamcorper justo, nec consectetur dolor arcu sed justo. Proin rutrum pharetra lectus, vel gravida ante venenatis sed. Mauris lacinia urna vehicula felis aliquet venenatis. Suspendisse non pretium sapien. Proin id dolor ultricies, dictum augue non, euismod ante. Vivamus et luctus augue, a luctus mi. Maecenas sit amet felis in magna vestibulum viverra vel ut est. Suspendisse potenti. Morbi nec odio pretium lacus laoreet volutpat sit amet at ipsum. Etiam pretium purus vitae tortor auctor, quis cursus metus vehicula. Integer ultricies facilisis arcu, non congue orci pharetra quis. Vivamus pulvinar ligula neque, et vehicula ipsum euismod quis. Aliquam ut mi elementum, malesuada velit ac, placerat leo. Donec vel neque condimentum, congue justo a, posuere tortor. Etiam mollis id ligula nec dapibus. Etiam tincidunt, nisi non cursus adipiscing, enim neque tincidunt leo, vel tincidunt quam leo non ligula. Proin a felis tellus. Pellentesque quis purus est. Nam consectetur erat quam, non ultricies tortor venenatis ac. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque at laoreet arcu. Mauris odio lorem, luctus facilisis ligula eget, malesuada pellentesque nulla.";
    
    NSArray *lorumIpsumArray = [lorumIpsum componentsSeparatedByString:@" "];
    
    int r = arc4random() % [lorumIpsumArray count];
    NSArray *lorumIpsumRandom = [lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, r)]];
    
    
//    NSArray *leftArray = [[NSArray alloc] initWithObjects:[lorumIpsumArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 20)]]];
    

    
    result = [lorumIpsumRandom componentsJoinedByString:@" "];
    
    return result;
    
    
}

@end
