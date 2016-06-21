//
//  MADDescriptionViewController.h
//  MADParadise
//
//  Created by Mariia Cherniuk on 13.06.16.
//  Copyright © 2016 marydort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MADDescriptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic, readwrite) NSString *descript;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;

@end
