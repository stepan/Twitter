//
//  User.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *backgroundImageURL;
@property (nonatomic, assign) NSString *tweetsCount;
@property (nonatomic, assign) NSString *followingCount;
@property (nonatomic, assign) NSString *followersCount;
@property (nonatomic, strong) NSDictionary *dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;
+ (void)removeCurrentUser;

@end
