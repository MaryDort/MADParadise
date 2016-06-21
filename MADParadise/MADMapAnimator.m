//
//  MADMapAnimator.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 15.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADMapAnimator.h"

@implementation MADMapAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    BOOL isPresenting = toViewController.presentedViewController != fromViewController;
    
    if (isPresenting) {
        UIView *container = [transitionContext containerView];
        toViewController.view.frame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
        
        [container addSubview:toViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toViewController.view.frame = finalFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromViewController.view.frame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

@end
