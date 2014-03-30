//
//  AppManager.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/29/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterClient.h"

@interface AppManager : NSObject
+ (TwitterClient *)twitterClient;
@end
