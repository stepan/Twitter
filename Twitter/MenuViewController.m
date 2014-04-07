//
//  MenuViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "MenuViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
- (IBAction)onProfileButton:(UIButton *)button;
- (IBAction)onHomeTimelineButton:(UIButton *)button;
- (IBAction)onMentionsButton:(UIButton *)button;

@end

@implementation MenuViewController

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

- (IBAction)onProfileButton:(UIButton *)button {
    [self.delegate menuViewController:self didFinishChangingController:[[ProfileViewController alloc] initWithUser:[User currentUser]]];
    
}

- (IBAction)onHomeTimelineButton:(UIButton *)button {
}

- (IBAction)onMentionsButton:(UIButton *)button {
}
@end
