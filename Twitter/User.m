//
//  User.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "User.h"

@interface User()

@end

@implementation User
static User * currentUser = nil;
NSString *const userKey = @"userKey";

+ (User *)currentUser{
    return currentUser;
}
+ (void)setCurrentUser:(User *)user{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dictionary = [defaults objectForKey:userKey];
    
}
@end
