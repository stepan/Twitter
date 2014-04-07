//
//  MenuViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController
@property(nonatomic, assign) id <MenuViewControllerDelegate> delegate;
@property(nonatomic, strong) UIViewController *selectedController;
@end

@protocol MenuViewControllerDelegate <NSObject>

- (void)menuViewController:(MenuViewController *)menuViewController didFinishChangingController:(UIViewController *)controller;

@end