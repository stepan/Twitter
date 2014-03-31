//
//  CreateTweetViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/30/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "CreateTweetViewController.h"
#import "AppManager.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface CreateTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation CreateTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleDone target:self action:@selector(onTweetCreate)];
    
    User *user = [User currentUser];
    self.userNameLabel.text = user.name;
    self.userScreenNameLabel.text = user.screenName;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:user.profileImageURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onTweetCreate{
    [[AppManager twitterClient] tweetWithStatus:self.tweetTextView.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to tweet");
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
