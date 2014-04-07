//
//  TweetViewCell.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "TweetViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MHPrettyDate.h"

@interface TweetViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
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
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:self.tweet.user.name];
    [name addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]} range:NSMakeRange(0, [name length])];
    NSMutableAttributedString *screenName = [[NSMutableAttributedString alloc] initWithString:self.tweet.user.screenName];
    [screenName addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} range:NSMakeRange(0, [screenName length])];
    [name appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
    [name appendAttributedString:screenName];
    
    self.nameLabel.attributedText = name;
    self.tweetTextLabel.text = self.tweet.text;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.tweet.user.profileImageURL]];
    self.whenLabel.text = [MHPrettyDate prettyDateFromDate:self.tweet.createdAt withFormat:MHPrettyDateShortRelativeTime];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.profileImage addGestureRecognizer:tapGestureRecognizer];
}

+ (TweetViewCell *)prototypeCell
{
    if(!prototypeCell){
        UINib *nib = [UINib nibWithNibName:@"TweetViewCell" bundle:nil];
        prototypeCell = [nib instantiateWithOwner:self options:nil][0];
    }
    return prototypeCell;
}

+ (CGFloat)heightForTweet:(Tweet *)tweet{
    TweetViewCell *pvc = [TweetViewCell prototypeCell];
    NSDictionary *attributes = @{NSFontAttributeName: pvc.tweetTextLabel.font};
    CGRect r = [tweet.text boundingRectWithSize:CGSizeMake(pvc.tweetTextLabel.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return ceil(pvc.frame.size.height - pvc.tweetTextLabel.frame.size.height + r.size.height);
}

- (void)onTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.delegate tweetViewCell:self onProfileImageTapWithTweet:self.tweet];
}
@end
