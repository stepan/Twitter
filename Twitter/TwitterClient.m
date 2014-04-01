//
//  TwitterClient.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "TwitterClient.h"
NSString * const TwitterClientLoggedInNotification = @"TwitterClientLoggedInNotification";

@implementation TwitterClient

+ (TwitterClient *)clientWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret{
    static TwitterClient *client = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        client = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"] consumerKey:consumerKey consumerSecret:consumerSecret];
    });
    return client;
}

- (void)login{
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString: @"sgtwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Success: %@", [requestToken description]);
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error) {
        NSLog(@"failure");
    }];
}

- (void)logout{
    [self deauthorize];
}

- (AFHTTPRequestOperation *)homeTimeLineWithSuuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    return [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:failure];
}

- (AFHTTPRequestOperation *)userWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    return [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:success failure:failure];
}

- (AFHTTPRequestOperation *)tweetWithStatus:(NSString *)status success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    return [self POST:@"1.1/statuses/update.json" parameters:@{@"status": status} success:success failure:failure];
}

- (AFHTTPRequestOperation *)toggleFavoriteWithTweet:(Tweet *)tweet success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *path;
    if(tweet.isFavorited) {
        path = @"1.1/favorites/create.json";
    }else{
        path = @"1.1/favorites/destroy.json";
    }
    return [self POST:path parameters:@{@"id": tweet.tweetID} success:success failure:failure];
}

- (AFHTTPRequestOperation *)retweetWithTweet:(Tweet *)tweet success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweet.tweetID];
    return [self POST:path parameters:nil success:success failure:failure];
}
@end
