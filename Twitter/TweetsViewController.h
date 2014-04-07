//
//  TweetsViewController.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TweetsViewControllerTimelineOptions) {
    TweetsViewControllerTimelineHome,
    TweetsViewControllerTimelineMentions,
};

@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, assign) TweetsViewControllerTimelineOptions timelineOption;
- (id)initWithTimeline:(TweetsViewControllerTimelineOptions)timelineOption;
@end
