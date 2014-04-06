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
        twitterClient = [TwitterClient clientWithConsumerKey:@"6rBpLQQ1bTJAsSEGSdWk9wcm4" consumerSecret:@"2V4vOZY8Lv4jyJkZ7Z8br9EoKYtyne3cEl5ZPHjRVOyev6GGVp"];
    }
    return twitterClient;
}
@end
