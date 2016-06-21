//
//  MADPlace.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 14.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface MADPlace : NSObject <MKAnnotation>

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign, readwrite) CLLocationDistance region;

- (instancetype)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate
                       region:(CLLocationDistance)region;

@end
