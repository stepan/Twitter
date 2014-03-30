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
    NSDictionary *dictionary = @{@"name": user.name, @"screenName": user.screenName, @"profileImageURL": user.profileImageURL};
    [defaults setObject:dictionary forKey:userKey];
    [defaults synchronize];
}

- (id)initWithNSDefaultsDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screenName"];
        self.profileImageURL = dictionary[@"profileImageURL"];
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

    }
    return self;
}

- (void)onLogout{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:userKey];
    [defaults synchronize];
}
@end
