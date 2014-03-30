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

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;


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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
