//
//  MADCollectionViewCell.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 10.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADCollectionViewCell.h"

@implementation MADCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.delegate = self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.scrollView.zoomScale = 1;
}

- (IBAction)pinButtonPressed:(UIButton *)sender {
    [_delegate didPressPinButtonInCell:self];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
