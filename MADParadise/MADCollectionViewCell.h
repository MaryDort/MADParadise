//
//  MADCollectionViewCell.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 10.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellButtonDelegate.h"

@interface MADCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *pinBotton;
@property (weak, nonatomic, readwrite) id <CollectionCellButtonDelegate> delegate;

@end
