//
//  ProfileViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/5/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "User.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) User *user;
@property(nonatomic, strong) MenuViewController *menuViewController;
- (id)initWithUser:(User *)user;
- (id)initWithUser:(User *)user menuViewController:(MenuViewController *)menuViewController;
@end
