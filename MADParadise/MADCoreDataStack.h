//
//  MADCoreDataStack.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 12.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MADCoreDataStack : NSObject

@property (nonatomic, readwrite, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readwrite, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readwrite, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedCoreDataStack;

- (void)saveObjects:(NSArray *)entities;
- (void)saveToStorage;

@end
