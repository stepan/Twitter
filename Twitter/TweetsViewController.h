//
//  TweetsViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "TweetViewCell.h"

typedef NS_ENUM(NSUInteger, TweetsViewControllerTimelineOptions) {
    TweetsViewControllerTimelineHome,
    TweetsViewControllerTimelineMentions,
};

@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TweetViewCellDelegate>
@property(nonatomic, strong) MenuViewController *menuViewController;
@property(nonatomic, assign) TweetsViewControllerTimelineOptions timelineOption;
- (id)initWithMenuViewController:(MenuViewController *)menuViewController timeline:(TweetsViewControllerTimelineOptions)timelineOption;
@end
