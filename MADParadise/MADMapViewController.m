//
//  MADMapViewController.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 14.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADMapViewController.h"
#import "MADPlace.h"

@interface MADMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *countLocationsLabel;

@end

@implementation MADMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MADPlace *lastObject = [_annotatins lastObject];
    [self showRegionWithCenterCoordinate:lastObject.coordinate radius:lastObject.region];
    
    _countLocationsLabel.text = [NSString stringWithFormat:@"Found %lu location(/s)🤗", (unsigned long)_annotatins.count];
    [_mapView addAnnotations:_annotatins];
}

- (void)showRegionWithCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                radius:(CLLocationDistance)radius {
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(centerCoordinate, radius * 2, radius * 2);

    _mapView.region = coordinateRegion;
}

- (IBAction)viewPressed:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
