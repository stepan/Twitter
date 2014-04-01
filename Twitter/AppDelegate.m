//
//  AppDelegate.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppManager.h"
#import "LoginViewController.h"
#import "TweetsViewController.h"
#import "NSURL+dictionaryFromQueryString.h"
#import "User.h"

@interface AppDelegate ()
@property (nonatomic, strong) LoginViewController *lvc;
@property (nonatomic, strong) TweetsViewController *tvc;
@property (nonatomic, strong) UINavigationController *uvc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.lvc = [[LoginViewController alloc] init];
    self.tvc = [[TweetsViewController alloc] init];
    self.uvc = [[UINavigationController alloc] initWithRootViewController:self.tvc];
    [self setRootController];
    [self.window makeKeyAndVisible];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:TwitterClientLoggedInNotification
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *notification)
    {
        [self setRootController];
    }];
    
    
    return YES;
}

- (void)setRootController{
    if ([AppManager twitterClient].authorized) {
        self.window.rootViewController = self.uvc;
    } else{
        self.window.rootViewController = self.lvc;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"sgtwitter"])
    {
        if ([url.host isEqualToString:@"oauth"])
        {
            NSDictionary *parameters = [url dictionaryFromQueryString];
            if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"]){
                [[AppManager twitterClient] fetchAccessTokenWithPath:@"/oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
                    [[AppManager twitterClient].requestSerializer saveAccessToken:accessToken];
                    [[NSNotificationCenter defaultCenter] postNotificationName:TwitterClientLoggedInNotification object:nil];                    
                    [[AppManager twitterClient] userWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                        [User setCurrentUser:[[User alloc] initWithDictionary:responseObject]];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    }];
                } failure:^(NSError *error) {
                }];
            }
        }
        return YES;
    }
    return NO;
}

@end
