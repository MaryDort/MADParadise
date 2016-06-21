//
//  AppDelegate.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 10.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "AppDelegate.h"
#import "MADCoreDataStack.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[MADCoreDataStack sharedCoreDataStack] saveToStorage];
}

@end
