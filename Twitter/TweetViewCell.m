//
//  TweetViewCell.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "TweetViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end

@implementation TweetViewCell
static TweetViewCell *prototypeCell = nil;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    [self styleCell];
}

- (void)styleCell{
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.tweetTextLabel.text = self.tweet.text;
    [self.profileImage setImageWithURL:self.tweet.user.profileImageURL];
    NSLog(@"%@", [[self class] prototypeCell]);
}

+ (TweetViewCell *)prototypeCell
{
    if(!prototypeCell){
        UINib *nib = [UINib nibWithNibName:@"TweetViewCell" bundle:nil];
        prototypeCell = [nib instantiateWithOwner:self options:nil][0];
    }
    return prototypeCell;
}

@end
