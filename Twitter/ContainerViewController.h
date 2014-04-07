//
//  ContainerViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface ContainerViewController : UIViewController <MenuViewControllerDelegate>
- (id)initWithMenuViewController:(MenuViewController *)menuViewController contentViewController:(UIViewController *)contentViewController;

@property(nonatomic, strong) MenuViewController *menuViewController;
@property(nonatomic, strong) UIViewController *contentViewController;
@property(nonatomic, strong) UIViewController *selectedViewController;
@end
