//
//  TwitterClient.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "Tweet.h"
#import "TweetsViewController.h"

extern NSString * const TwitterClientLoggedInNotification;
extern NSString * const TwitterClientLoggedOutNotification;
extern NSString * const TwitterClientAddedTweetNotification;

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *)clientWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;
- (void)login;
- (void)logout;
- (AFHTTPRequestOperation *)timeLineWithTimelineOption:(TweetsViewControllerTimelineOptions)timelineOption success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *)userWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *)tweetWithStatus:(NSString *)status success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *)toggleFavoriteWithTweet:(Tweet *)tweet success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *)retweetWithTweet:(Tweet *)tweet success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *)userTimelineWithScreenName:(NSString *)screenName success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
