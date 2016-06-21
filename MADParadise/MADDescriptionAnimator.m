//
//  MADAnimator.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 13.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDescriptionAnimator.h"

@implementation MADDescriptionAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BOOL isPresenting = toViewController.presentedViewController != fromViewController;
    
    if (isPresenting) {
        UIView *container = [transitionContext containerView];
        toViewController.view.alpha = 0.f;
        
        [container addSubview:toViewController.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toViewController.view.alpha = 1.f;
                             toViewController.view.layer.affineTransform = CGAffineTransformMakeScale(1.2f, 1.2f);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                              animations:^{
                                                  toViewController.view.layer.affineTransform = CGAffineTransformMakeScale(1.f, 1.f);
                                              }];
                             
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromViewController.view.alpha = 0.f;
                             fromViewController.view.layer.affineTransform = CGAffineTransformMakeScale(1.2f, 1.2f);
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

@end
