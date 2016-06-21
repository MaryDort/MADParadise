//
//  MADIsland+CoreDataProperties.h
//  
//
//  Created by Mariia Cherniuk on 17.06.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MADIsland.h"

NS_ASSUME_NONNULL_BEGIN

@interface MADIsland (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *islandName;
@property (nullable, nonatomic, retain) NSString *descript;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *path;

@end

NS_ASSUME_NONNULL_END
