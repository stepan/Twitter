//
//  TweetsViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 3/27/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetViewCell.h"

@interface TweetsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - tableview methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:@"TweetViewCell"];
}

@end
