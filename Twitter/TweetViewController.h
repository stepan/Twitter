//
//  TweetViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
- (id)initWithTweet:(Tweet *)tweet;
@end
