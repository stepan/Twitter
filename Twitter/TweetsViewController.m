//
//  TweetsViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "AppManager.h"
#import "AppDelegate.h"
#import "TweetsViewController.h"
#import "TweetViewController.h"
#import "TweetViewCell.h"
#import "Tweet.h"
#import "User.h"
#import "CreateTweetViewController.h"
#import "ProfileViewController.h"



@interface TweetsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) TweetViewCell *prototypeCell;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTimeline:(TweetsViewControllerTimelineOptions)timelineOption{
    self = [super init];
    if (self) {
        self.timelineOption = timelineOption;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TweetsViewController viewDidLoad");
    [[NSNotificationCenter defaultCenter] addObserverForName:TwitterClientLoggedOutNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.tweets = [NSMutableArray array];
        [User removeCurrentUser];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:TwitterClientLoggedInNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self fetchTweets];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:TwitterClientAddedTweetNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.tweets insertObject:note.object atIndex:0];
        [self.tableview scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        [self.tableview reloadData];
    }];
    
    self.title = @"Tweets";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(onLogout)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,30,30);
    [button1 setBackgroundImage:[UIImage imageNamed: @"compose.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(onNewTweet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableview addSubview:self.refreshControl];
    self.tableview.separatorInset = UIEdgeInsetsZero;
    [self.tableview registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    [self fetchTweets];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"TweetsViewController viewDidAppear");
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"TweetsViewController viewWillAppear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"TweetsViewController viewDidDisappear");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"TweetsViewController viewWillDisappear");
}

- (void)fetchTweets{
    [[AppManager twitterClient] timeLineWithTimelineOption:self.timelineOption success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = [Tweet tweetsWithObject:responseObject];
        [self.tableview reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableview reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLogout{
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithUser:[User currentUser]];
    [self.navigationController pushViewController:profileViewController animated:YES];
    return;
    [[AppManager twitterClient] logout];
    [(AppDelegate *)([UIApplication sharedApplication].delegate) setRootController];
}

- (void)onNewTweet{
    CreateTweetViewController *controller = [[CreateTweetViewController alloc] init];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:unc animated:YES completion:nil];
}

# pragma mark - tableview methods

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
