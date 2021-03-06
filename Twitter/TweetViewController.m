//
//  TweetViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MHPrettyDate.h"
#import "AppManager.h"
#import "CreateTweetViewController.h"
#import "ProfileViewController.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
- (IBAction)onTap:(UITapGestureRecognizer *)sender;


@end

@implementation TweetViewController
static NSDateFormatter *formatter = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTweet:(Tweet *)tweet{
    self = [super init];
    if (self) {
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.favoriteButton addTarget:self action:@selector(onFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [self.retweetButton addTarget:self action:@selector(onRetweet:) forControlEvents:UIControlEventTouchUpInside];
    [self.replyButton addTarget:self action:@selector(onReply:) forControlEvents:UIControlEventTouchUpInside];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [self.replyButton setImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    self.title = @"Tweet";
    self.tweetNameLabel.text = self.tweet.user.name;
    self.tweetScreenNameLabel.text = self.tweet.user.screenName;
    self.tweetTextLabel.text = self.tweet.text;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.tweet.user.profileImageURL]];
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yy, hh:mm a"];
    }
    self.whenLabel.text = [formatter stringFromDate:self.tweet.createdAt];
    [self styleButton:self.favoriteButton forState:self.tweet.isFavorited];
    [self styleButton:self.retweetButton forState:self.tweet.isRetweeted];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReply:(UIButton *)button{
    CreateTweetViewController *controller = [[CreateTweetViewController alloc] initWithInitialText:[NSString stringWithFormat:@"%@ ", self.tweet.user.screenName]];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:unc animated:YES completion:nil];
}

- (void)onRetweet:(UIButton *)button{
    if (!self.tweet.isRetweeted) {
        self.tweet.isRetweeted = YES;
        [self styleButton:button forState:YES];
        [[AppManager twitterClient] retweetWithTweet:self.tweet success:^(AFHTTPRequestOperation *operation, id responseObject) {
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    }

}

- (void)onFavorite:(UIButton *)button{
    self.tweet.isFavorited = !self.tweet.isFavorited;
    [self styleButton:button forState:self.tweet.isFavorited];

    [[AppManager twitterClient] toggleFavoriteWithTweet:self.tweet success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.tweet.isFavorited = !self.tweet.isFavorited;
        [self styleButton:button forState:self.tweet.isFavorited];
    }];
}

- (void)styleButton:(UIButton *)button forState:(BOOL)state{
    if (state) {
        button.tintColor = [UIColor greenColor];
    }
    else{
        button.tintColor = [UIColor darkGrayColor];
    }
}
- (IBAction)onTap:(UITapGestureRecognizer *)tapGestureRecognizer{
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithUser:self.tweet.user];
    [self.navigationController pushViewController:profileViewController animated:YES];
}
@end
