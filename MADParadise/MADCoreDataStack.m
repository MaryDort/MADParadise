//
//  MADCoreDataStack.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 12.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCoreDataStack.h"
#import "MADIsland.h"

@implementation MADCoreDataStack

+ (instancetype)sharedCoreDataStack {
    static MADCoreDataStack *coreDataStack = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        coreDataStack = [[MADCoreDataStack alloc] init];
    });
    
    return coreDataStack;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"paradiseModel" ofType:@"momd"]];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Paradise.sqlite"];
    NSError *error;
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        
        NSLog(@"%@", [error description]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    return _managedObjectContext;
}

#pragma mark - Private

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] firstObject];
}

- (void)saveObjects:(NSArray *)entities {
    NSArray *uniqueIslands = [self uniquenessCheck:entities];
    
    for (NSDictionary *info in uniqueIslands) {
        MADIsland *entity = (MADIsland *)[NSEntityDescription insertNewObjectForEntityForName:@"MADIsland"
                                                                       inManagedObjectContext:self.managedObjectContext];
        entity.islandName = info[@"islandName"];
        entity.path = info[@"howToGetThere"];
        entity.imageURL = info[@"imageURL"];
        entity.descript = info[@"description"];
        entity.category = info[@"category"];
    }
    
    [self saveToStorage];
}

- (NSArray *)uniquenessCheck:(NSArray *)islands {
    NSArray *islandsName = [islands valueForKeyPath:@"islandName"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"islandName IN %@", islandsName];
    NSArray *response = [[self fetchingDistinctValueByPredicate:predicate] valueForKeyPath:@"islandName"];
    NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:
                                    ^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
                                        return ![response containsObject:evaluatedObject[@"islandName"]];
                                    }];
    
    return [islands filteredArrayUsingPredicate:filterPredicate];
}

- (NSArray *)fetchingDistinctValueByPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MADIsland"
                                              inManagedObjectContext:self.managedObjectContext];
    request.entity = entity;
    request.predicate = predicate;
    request.sortDescriptors = [[NSArray alloc] init];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error description]);
    }

    return array;
}

- (void)saveToStorage {
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@", [error description]);
    }
}

@end
