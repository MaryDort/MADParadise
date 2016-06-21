//
//  MADCollectionViewController.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 17.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MADCollectionViewController : UICollectionViewController

@property (nonatomic, readwrite, assign) NSInteger index;
@property (nonatomic, readwrite, assign) NSString *category;

- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)flowLayout;

@end
