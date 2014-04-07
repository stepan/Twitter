//
//  TweetViewCell.h
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol TweetViewCellDelegate;


@interface TweetViewCell : UITableViewCell
@property (nonatomic, strong) Tweet *tweet;
+ (CGFloat)heightForTweet:(Tweet *)tweet;
@property(nonatomic, assign) id <TweetViewCellDelegate> delegate;
@end

@protocol TweetViewCellDelegate <NSObject>
- (void)tweetViewCell:(TweetViewCell *)tweetViewCell onProfileImageTapWithTweet:(Tweet *)tweet;
@end