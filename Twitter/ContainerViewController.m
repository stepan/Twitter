//
//  ContainerViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "ContainerViewController.h"

static CGFloat MAXMENUWIDTH = 270.0;

@interface ContainerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, assign) BOOL isMenuBeingShown;

@end

@implementation ContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMenuViewController:(MenuViewController *)menuViewController{
    self  = [super init];
    if (self) {
        self.menuViewController = menuViewController;
        self.contentViewController = menuViewController.selectedController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.containerView addSubview:self.menuViewController.view];
    CGRect menuFrame = self.containerView.bounds;
    menuFrame.size.width = MAXMENUWIDTH;
    self.menuViewController.delegate = self;
    self.menuViewController.view.frame = menuFrame;
    self.contentViewController.view.frame = self.containerView.frame;
    [self bindGestureRecognizer];
}

- (void)setContentViewController:(UIViewController *)contentViewController{
    if (_contentViewController) {
        [_contentViewController willMoveToParentViewController:nil];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController removeFromParentViewController];
    }
    CGRect frame = self.containerView.frame;
    frame.origin.x = MAXMENUWIDTH;
    _contentViewController = contentViewController;
    _contentViewController.view.frame = frame;
    [self bindGestureRecognizer];
    [self addChildViewController:_contentViewController];
    [_contentViewController didMoveToParentViewController:self];
}

- (void)bindGestureRecognizer{
   
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.contentViewController.view addGestureRecognizer:panGestureRecognizer];
    [self.containerView addSubview:self.contentViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPan:(UIPanGestureRecognizer *)panGestureRecognizer{
    CGPoint velocity = [panGestureRecognizer velocityInView:self.containerView];
    CGRect frame = panGestureRecognizer.view.frame;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {

        CGFloat newXPosition = frame.origin.x + (velocity.x)/50;
        if (newXPosition < 0) {
            newXPosition = 0;
        }
        if (newXPosition > MAXMENUWIDTH) {
            newXPosition = MAXMENUWIDTH;
        }
        frame.origin.x = newXPosition;
        panGestureRecognizer.view.frame = frame;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat endPosition;
        if (frame.origin.x > 250 || (frame.origin.x > 135 && velocity.x > 0)) {
            endPosition = MAXMENUWIDTH;
        }else {
            endPosition = 0;
        }
        frame.origin.x = endPosition;

        if (frame.origin.x == 0 && self.isMenuBeingShown) {
            self.isMenuBeingShown = NO;
        } else if (frame.origin.x == MAXMENUWIDTH && !self.isMenuBeingShown) {
            self.isMenuBeingShown = YES;
        }
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            panGestureRecognizer.view.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
   
}

- (void)switchController:(UIViewController *)controller{
    if (self.selectedViewController == controller) {
        return;
    }
    UIViewController *oldController = self.selectedViewController;
    self.selectedViewController = controller;
    
    [oldController willMoveToParentViewController:nil];
    [oldController removeFromParentViewController];
    
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
}

#pragma mark - menu view controller methods

- (void)menuViewController:(MenuViewController *)menuViewController didFinishChangingController:(UIViewController *)controller{
    self.contentViewController = controller;
    
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:40 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentViewController.view.frame = self.containerView.frame;
    } completion:^(BOOL finished) {
        
    }];
}

@end
