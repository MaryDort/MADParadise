//
//  MADTransitionDelegate.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 15.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface MADTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, readwrite, weak) id <UIViewControllerAnimatedTransitioning> animator;

@end
