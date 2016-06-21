//
//  MADDownloader.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 12.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADDownloader : NSObject

+ (instancetype)sharedDownloader;

- (void)loadDataWithURL:(NSURL *)URL complitionBlock:(void(^)(NSData *imageData))complitionBlock;

@end
