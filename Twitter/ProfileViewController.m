//
//  ProfileViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 4/5/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "TweetViewCell.h"
#import "TweetViewController.h"
#import "AppManager.h"
#import "TweetsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweets;

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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    [self fetchTweets];
    
    
    self.userNameLabel.text = self.user.name;
    self.userScreenNameLabel.text = self.user.screenName;
    self.tweetsCountLabel.text = [NSString stringWithFormat:@"%@", self.user.tweetsCount];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
    self.followersCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followersCount];
    [self.profileImage setImageWithURL:[[NSURL alloc] initWithString:self.user.profileImageURL]];
    [self.backgroundImage setImageWithURL:[[NSURL alloc] initWithString:self.user.backgroundImageURL]];

}

- (void)fetchTweets{
    [[AppManager twitterClient] userTimelineWithScreenName:self.user.screenName success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = [Tweet tweetsWithObject:responseObject];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView reloadData];
    }];
}

- (void)onMenuButton:(UIButton *)button{
    [self.menuViewController toggleMenuFromController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetViewCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TweetViewCell heightForTweet:self.tweets[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetViewController *tweetViewController = [[TweetViewController alloc] initWithTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:tweetViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
