//
//  MADDownloader.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 12.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDownloader.h"

@implementation MADDownloader

+ (instancetype)sharedDownloader {
    static MADDownloader *downloader = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        downloader = [[MADDownloader alloc] init];
    });
    
    return downloader;
}

- (void)downloadDataWithURL:(NSURL *)URL complitionBlock:(void (^)(NSData *))complitionBlock {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *sessionDownloadTask = [session dataTaskWithRequest:request
                                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                              if (error) {
                                                                  NSLog(@"%@", [error description]);
                                                              }
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  complitionBlock(data);
                                                              });
                                                          }];
    [sessionDownloadTask resume];
}

@end
