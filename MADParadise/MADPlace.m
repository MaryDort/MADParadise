//
//  MADPlace.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 14.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADPlace.h"

@implementation MADPlace

- (instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate
                       region:(CLLocationDistance)region {
    self = [super init];
    
    if (self) {
        _title = title;
        _coordinate = coordinate;
        _region = region;
    }
    
    return self;
}

@end
