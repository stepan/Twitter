//
//  ContainerViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController
- (id)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;

@property(nonatomic, strong) UIViewController *leftViewController;
@property(nonatomic, strong) UIViewController *rightViewController;
@property(nonatomic, strong) UIViewController *selectedViewController;
@end
