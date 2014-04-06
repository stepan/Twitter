//
//  ProfileViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 4/5/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
@property (nonatomic, strong) User *user;
- (id)initWithUser:(User *)user;
@end
