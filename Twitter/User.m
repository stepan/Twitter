//
//  User.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

@interface User()

@end

@implementation User
static User * currentUser = nil;
NSString *const userKey = @"userKey";

+ (User *)currentUser{
    if (!currentUser) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [defaults objectForKey:userKey];
        if(dictionary){
            currentUser = [[User alloc] initWithNSDefaultsDictionary:dictionary];
        }
    }
    return currentUser;
}
+ (void)setCurrentUser:(User *)user{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = @{@"name": user.name, @"screenName": user.screenName, @"profileImageURL": user.profileImageURL, @"backgroundImageURL": user.backgroundImageURL, @"tweetsCount": @(user.tweetsCount), @"followersCount": @(user.followersCount), @"followingCount": @(user.followingCount)};
    [defaults setObject:dictionary forKey:userKey];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:TwitterClientLoggedInNotification object:nil];    
}

- (id)initWithNSDefaultsDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screenName"];
        self.profileImageURL = dictionary[@"profileImageURL"];
        self.backgroundImageURL = dictionary[@"backgroundImageURL"];
        self.tweetsCount = [dictionary[@"tweetsCount"] integerValue];
        self.followersCount = [dictionary[@"followersCount"] integerValue];
        self.followingCount = [dictionary[@"followingCount"] integerValue];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = [NSString stringWithFormat:@"@%@", dictionary[@"screen_name"]];
        self.profileImageURL = [dictionary[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"_normal" withString:@"_bigger"];
        self.backgroundImageURL = dictionary[@"profile_background_image_url"];
        self.tweetsCount = [dictionary[@"statuses_count"] integerValue];
        self.followersCount = [dictionary[@"followers_count"] integerValue];
        self.followingCount = [dictionary[@"friends_count"] integerValue];

    }
    return self;
}

+ (void)removeCurrentUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:userKey];
    [defaults synchronize];
}
@end
