//
//  MADTransitionDelegate.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 15.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADTransitionDelegate.h"
#import "MADMapAnimator.h"
#import "MADDescriptionAnimator.h"

@implementation MADTransitionDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _animator;
}

@end
