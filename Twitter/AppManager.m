//
//  AppManager.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/29/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager
static TwitterClient *twitterClient;
+ (TwitterClient *)twitterClient{
    if (!twitterClient) {
        twitterClient = [TwitterClient clientWithConsumerKey:@"kGGrh1DtGTwO9RrphlWN0Oceh" consumerSecret:@"auGeHhj5A7rB0VdI2tHrh0RpmZbsuwEioIKY80zaDmhUOnkzLt"];
    }
    return twitterClient;
}
@end
