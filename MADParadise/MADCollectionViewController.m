//
//  MADCollectionViewController.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 17.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCollectionViewController.h"
#import "MADCoreDataStack.h"
#import "MapKit/MapKit.h"
#import "MADIsland+CoreDataProperties.h"
#import "MADDownloader.h"
#import "MADCollectionViewCell.h"
#import "MADTransitionDelegate.h"
#import "MADDescriptionAnimator.h"
#import "MADDescriptionViewController.h"
#import "MADMapViewController.h"
#import "MADMapAnimator.h"
#import "CollectionCellButtonDelegate.h"
#import "UICollectionView+NSFetchedResultsController.h"
#import "MADQuestionsViewController.h"

@interface MADCollectionViewController () <NSFetchedResultsControllerDelegate, UICollectionViewDelegateFlowLayout, CollectionCellButtonDelegate>

@property (weak, nonatomic, readwrite) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, readwrite, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite, strong) CLGeocoder *geocoder;
@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readwrite) MADTransitionDelegate *transitionDelegate;
@property (strong, nonatomic, readwrite) MADMapAnimator *mapAnimator;
@property (strong, nonatomic, readwrite) MADDescriptionAnimator *descriptionAnimator;
@property (assign, nonatomic, readwrite) CGSize currentViewSize;

@end

@implementation MADCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)flowLayout {
    self = [super initWithCollectionViewLayout:flowLayout];
    
    if (self) {
        _flowLayout = flowLayout;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    
    _geocoder = [[CLGeocoder alloc] init];
    _transitionDelegate = [[MADTransitionDelegate alloc] init];
    _mapAnimator = [[MADMapAnimator alloc] init];
    _descriptionAnimator = [[MADDescriptionAnimator alloc] init];
      
    self.collectionView.contentInset = UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0.f, 0.f, 0.f);
    [self.collectionView registerNib:[UINib nibWithNibName:@"MADCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _currentViewSize = self.view.frame.size;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%ld", (long)[[UIDevice currentDevice] orientation]);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    
    NSLog(@"%lu", (unsigned long)sectionInfo.numberOfObjects);
    
    return sectionInfo.numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    MADIsland *island = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (!island.image) {
        [[MADDownloader sharedDownloader] downloadDataWithURL:[NSURL URLWithString:island.imageURL] complitionBlock:^(NSData *imageData) {
            island.image = imageData;
            cell.imageView.image = [UIImage imageWithData:imageData];
        }];
        cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    } else {
        cell.imageView.image = [UIImage imageWithData:island.image];
    }
    cell.label.text = island.islandName;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MADIsland *island = [self.fetchedResultsController objectAtIndexPath:indexPath];
    MADDescriptionViewController *descriptionViewControlle = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MADDescriptionViewController"];
    
    descriptionViewControlle.modalPresentationStyle = UIModalPresentationCustom;
    _transitionDelegate.animator = _descriptionAnimator;
    descriptionViewControlle.transitioningDelegate = _transitionDelegate;
    
    if (_index == 0) {
        descriptionViewControlle.descript = [NSString stringWithFormat:@"   %@\n\n   HOW TO GET THERE\n   %@", island.descript, island.path];
    } else {
        descriptionViewControlle.descript = [NSString stringWithFormat:@"   %@\n", island.descript];
    }
    
    [self presentViewController:descriptionViewControlle animated:YES completion:nil];
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }

    _managedObjectContext = [[MADCoreDataStack sharedCoreDataStack] managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"islandName" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category = %@", _category];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADIsland"
                                              inManagedObjectContext:_managedObjectContext];
    request.predicate = predicate;
    request.entity = entity;
    request.fetchBatchSize = 5;
    request.sortDescriptors = @[sortDescriptor];

    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:request
                                                             managedObjectContext:_managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:nil];
    aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;

    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

    return _fetchedResultsController;
}

#pragma mark -  protocolUICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentViewSize.width > _currentViewSize.height) {
        return CGSizeMake(_currentViewSize.width/2 - 10.f, _currentViewSize.height);
    }
    return CGSizeMake(_currentViewSize.width - 10, _currentViewSize.height/2);
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    _currentViewSize = size;
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    [self.collectionView addChangeForSection:sectionInfo atIndex:sectionIndex forChangeType:type];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.collectionView addChangeForObjectAtIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView commitChanges];
}

#pragma mark - CollectionCellButtonDelegate

- (void)didPressPinButtonInCell:(MADCollectionViewCell *)cell {
    NSString *result = cell.label.text;
    NSRange range = [cell.label.text rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]];
    
    if (range.location != NSNotFound) {
        result = [cell.label.text substringToIndex:range.location];
    }
    
    [_geocoder geocodeAddressString:result completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Location doesn't found!"
                                                                             message:@"🙀"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
            [self presentViewController:alertVC animated:YES completion:nil];
        } else {
            [self configureMap:placemarks];
        }
    }];
}

- (void)configureMap:(NSArray *)placemarks {
    MADMapViewController *mapVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MADMapViewController"];
    mapVC.modalPresentationStyle = UIModalPresentationCustom;
    _transitionDelegate.animator = _mapAnimator;
    mapVC.transitioningDelegate = _transitionDelegate;
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (CLPlacemark *placemark in placemarks) {
        CLLocationDistance radius = [(CLCircularRegion*)placemark.region radius];
        
        [results addObject:[[MADPlace alloc] initWithTitle:placemark.name
                                                coordinate:placemark.location.coordinate
                                                    region:radius]];
    }
    mapVC.annotatins = results;
    [self presentViewController:mapVC animated:YES completion:nil];
}

@end
