//
//  Tweet.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
+ (NSMutableArray *)tweetsWithObject:(id)object{
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in object)
    {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        //self.createdAt = [[NSDate alloc] init]
    }
    return self;
}

@end
