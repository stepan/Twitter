//
//  Tweet.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *tweetID;
@property (nonatomic, assign) BOOL isFavorited;
@property (nonatomic, assign) BOOL isRetweeted;
@property (nonatomic, assign) NSUInteger favoriteCount;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDictionary *dictionary;

+ (NSMutableArray *)tweetsWithObject:(id)object;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
