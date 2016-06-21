//
//  MADDescriptionViewController.m
//  MADParadise
//
//  Created by Mariia Cherniuk on 13.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import "MADDescriptionViewController.h"
#import "MADMapViewController.h"

@interface MADDescriptionViewController () <UIContentContainer>

@end

@implementation MADDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self configureView];
}

- (void)setDescript:(NSString *)descript {
    if (![_descript isEqualToString:descript]) {
        _descript = descript;
    }
}

- (void)configureView {
    _textView.text = _descript;
}

- (IBAction)viewPressed:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
