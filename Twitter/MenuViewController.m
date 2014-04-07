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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UIViewController *profileController;
@property(nonatomic, strong) UIViewController *homeTimelineController;
@property(nonatomic, strong) UIViewController *mentionsController;
@property(nonatomic, strong) User *currentUser;
@property(nonatomic, strong) NSArray *links;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentUser = [User currentUser];
        self.profileController = [[UINavigationController alloc] initWithRootViewController:[[ProfileViewController alloc] initWithUser:self.currentUser menuViewController:self]];
        self.homeTimelineController = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] initWithMenuViewController:self timeline:TweetsViewControllerTimelineHome]];
        self.mentionsController = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] initWithMenuViewController:self timeline:TweetsViewControllerTimelineMentions]];
        self.selectedController = self.homeTimelineController;
        self.links = @[@{@"title": @"Profile", @"controller":self.profileController}, @{@"title": @"Home Timeline", @"controller":self.homeTimelineController}, @{@"title": @"Mentions", @"controller":self.mentionsController}, @{@"title": @"Logout"}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.userNameLabel.text = self.currentUser.name;
    self.userScreenNameLabel.text = self.currentUser.screenName;
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.currentUser.profileImageURL]];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeController:(UIViewController *)controller{
    [self.delegate menuViewController:self didFinishChangingController:controller];
}

- (void)toggleMenuFromController:(UIViewController *)controller{
    [self.delegate menuViewController:self shouldToggleMenuControllerFromController:controller];
}

# pragma mark - tableview methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.links count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.links[indexPath.row][@"title"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        [[AppManager twitterClient] logout];
        [(AppDelegate *)([UIApplication sharedApplication].delegate) setRootController];
        return;
    }
    [self.delegate menuViewController:self didFinishChangingController:self.links[indexPath.row][@"controller"]];
}

@end
