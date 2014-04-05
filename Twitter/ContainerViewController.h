//
//  ContainerViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController
- (id)initWithRearViewController:(UIViewController *)rearViewController frontViewController:(UIViewController *)frontViewController;

@property(nonatomic, strong) UIViewController *rearViewController;
@property(nonatomic, strong) UIViewController *frontViewController;
@property(nonatomic, strong) UIViewController *selectedViewController;
@end
