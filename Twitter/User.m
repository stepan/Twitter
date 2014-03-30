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

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = [NSString stringWithFormat:@"@%@", dictionary[@"screen_name"]];
        self.profileImageURL = [[NSURL alloc] initWithString:[dictionary[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"_normal" withString:@"_bigger"]];
    }
    return self;
}
@end
