//
//  ProfileViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 4/5/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;


@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUser:(User *)user{
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

- (id)initWithUser:(User *)user menuViewController:(MenuViewController *)menuViewController{
    self = [super init];
    if (self) {
        self.user = user;
        self.menuViewController = menuViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profile";
    
    if (self.menuViewController) {
        UIButton *menu = [[UIButton alloc] init];
        menu.frame=CGRectMake(0,0,30,30);
        [menu setBackgroundImage:[UIImage imageNamed: @"menu.png"] forState:UIControlStateNormal];
        [menu addTarget:self action:@selector(onMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menu];
    }
    self.userNameLabel.text = self.user.name;
    self.userScreenNameLabel.text = self.user.screenName;
    self.tweetsCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.tweetsCount];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.followingCount];
    self.followersCountLabel.text = [NSString stringWithFormat:@"%ld", self.user.followersCount];
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.user.profileImageURL]];
    [self.backgroundImage setImageWithURL:[[NSURL alloc] initWithString:self.user.backgroundImageURL]];

}

- (void)onMenuButton:(UIButton *)button{
    [self.menuViewController toggleMenuFromController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
