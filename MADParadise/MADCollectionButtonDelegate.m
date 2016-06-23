//
//  MADCollectionButtonDelegate.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 22.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCollectionButtonDelegate.h"
#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "MADCollectionViewCell.h"
#import "MADMapViewController.h"

@implementation MADCollectionButtonDelegate

//- (void)didPressPinButtonInCell:(MADCollectionViewCell *)cell {
//    NSString *result = cell.label.text;
//    NSRange range = [cell.label.text rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]];
//    
//    if (range.location != NSNotFound) {
//        result = [cell.label.text substringToIndex:range.location];
//    }
//    
//    [_geocoder geocodeAddressString:result completionHandler:^(NSArray *placemarks, NSError *error) {
//        if (error) {
//            NSLog(@"%@", [error description]);
//        } else {
//            [self configureMap:placemarks];
//        }
//    }];
//}
//
//- (void)configureMap:(NSArray *)placemarks {
//    MADMapViewController *mapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MADMapViewController"];
//    mapVC.modalPresentationStyle = UIModalPresentationCustom;
//    _transitionDelegate.animator = _mapAnimator;
//    mapVC.transitioningDelegate = _transitionDelegate;
//    
//    NSMutableArray *results = [[NSMutableArray alloc] init];
//    
//    for (CLPlacemark *placemark in placemarks) {
//        CLLocationDistance radius = [(CLCircularRegion*)placemark.region radius];
//        
//        [results addObject:[[MADPlace alloc] initWithTitle:placemark.name
//                                                coordinate:placemark.location.coordinate
//                                                    region:radius]];
//    }
//    mapVC.annotatins = results;
//    [self presentViewController:mapVC animated:YES completion:nil];
//}

@end
