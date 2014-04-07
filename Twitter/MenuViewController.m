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
#import "TweetsViewController.h"
#import "AppManager.h"
#import "AppDelegate.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
- (IBAction)onProfileButton:(UIButton *)button;
- (IBAction)onHomeTimelineButton:(UIButton *)button;
- (IBAction)onMentionsButton:(UIButton *)button;
- (IBAction)onLogout:(UIButton *)button;
@property(nonatomic, strong) UIViewController *profileController;
@property(nonatomic, strong) UIViewController *homeTimelineController;
@property(nonatomic, strong) UIViewController *mentionsController;
@property(nonatomic, strong) User *currentUser;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentUser = [User currentUser];
        self.profileController = [[UINavigationController alloc] initWithRootViewController:[[ProfileViewController alloc] initWithUser:self.currentUser]];
        self.homeTimelineController = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] initWithMenuViewController:self timeline:TweetsViewControllerTimelineHome]];
        self.mentionsController = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] initWithMenuViewController:self timeline:TweetsViewControllerTimelineMentions]];
        self.selectedController = self.homeTimelineController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userNameLabel.text = self.currentUser.name;
    self.userScreenNameLabel.text = self.currentUser.screenName;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.currentUser.profileImageURL]];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onProfileButton:(UIButton *)button {
    [self changeController:self.profileController];
}

- (IBAction)onHomeTimelineButton:(UIButton *)button {
    [self changeController:self.homeTimelineController];
}

- (IBAction)onMentionsButton:(UIButton *)button {
    [self changeController:self.mentionsController];
}

- (IBAction)onLogout:(UIButton *)button{
    [[AppManager twitterClient] logout];
    [(AppDelegate *)([UIApplication sharedApplication].delegate) setRootController];
}

- (void)changeController:(UIViewController *)controller{
    [self.delegate menuViewController:self didFinishChangingController:controller];
}

- (void)toggleMenuFromController:(UIViewController *)controller{
    [self.delegate menuViewController:self shouldToggleMenuControllerFromController:controller];
}

@end
