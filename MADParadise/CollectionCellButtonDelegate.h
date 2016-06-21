//
//  CollectionCellButtonDelegate.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 14.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MADCollectionViewCell;

@protocol CollectionCellButtonDelegate <NSObject>

- (void)didPressPinButtonInCell:(MADCollectionViewCell *)cell;

@end
