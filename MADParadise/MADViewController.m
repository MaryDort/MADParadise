//
//  MADViewController.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 10.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADViewController.h"
#import "MADCoreDataStack.h"

#import "MADCollectionViewController.h"

@interface MADViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong, readwrite) UIPageViewController *pageViewController;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *managetObjectContext;

@end

@implementation MADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCurrentInfoByIndex:0];
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.dataSource = self;
    
    [_pageViewController setViewControllers:@[[self viewControllerWithIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_pageViewController didMoveToParentViewController:self];
}

#pragma mark - Private

- (void)getCurrentInfoByIndex:(NSInteger)index {
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"islands" ofType:@"json"];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    [[MADCoreDataStack sharedCoreDataStack] saveObjects:result[@"menu"][@"items"]];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [(MADCollectionViewController *)viewController index];
    
    if (index == 0) {
        index = 2;
    }
    
    index --;
    
    return [self viewControllerWithIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [(MADCollectionViewController *)viewController index];
    
    index ++;
    
    if (index > 1) {
        index = 0;
    }
    
    return [self viewControllerWithIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (MADCollectionViewController *)viewControllerWithIndex:(NSInteger)index {
    MADCollectionViewController *controller = [[MADCollectionViewController alloc] initWithCollectionViewFlowLayout:[[UICollectionViewFlowLayout alloc] init]];
    controller.index = index;
    
    if (index == 0) {
        controller.category = @"philippines";
    } else {
        controller.category = @"seychelles";
    }
    
    return controller;
}

@end
