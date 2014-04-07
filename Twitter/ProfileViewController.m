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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profile";
    self.userNameLabel.text = self.user.name;
    self.userScreenNameLabel.text = self.user.screenName;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.user.profileImageURL]];
    [self.backgroundImage setImageWithURL:[[NSURL alloc] initWithString:self.user.backgroundImageURL]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
