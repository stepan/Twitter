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
@property (nonatomic, assign) BOOL isInitialText;
@property (nonatomic, strong) NSString *initialText;
@end

@implementation CreateTweetViewController

- (id)initWithInitialText:(NSString *)text{
    self = [super init];
    self.initialText = text;
    return self;
}

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
    if (self.initialText == nil) {
        self.isInitialText = YES;
    }
    else{
        self.isInitialText = NO;
    }
    [self.tweetTextView becomeFirstResponder];
    self.tweetTextView.delegate = self;
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
    NSUInteger count = [self.tweetTextView.text length];

    
    if (count > 0 && count <= 140 && !self.isInitialText) {
        Tweet * tweet = [[Tweet alloc] initWithText:self.tweetTextView.text];
        [[NSNotificationCenter defaultCenter] postNotificationName:TwitterClientAddedTweetNotification object:tweet];
        [[AppManager twitterClient] tweetWithStatus:self.tweetTextView.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark - Text View methods

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.isInitialText) {
        textView.text = @"What's happening?";
        textView.selectedRange = NSMakeRange(0, 0);
    }
    else{
        textView.text = self.initialText;
    }

}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.isInitialText) {
        self.isInitialText = NO;
        textView.text = [textView.text substringToIndex:1];
    }
}
@end
