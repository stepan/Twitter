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

- (id)initWithRearViewController:(UIViewController *)rearViewController frontViewController:(UIViewController *)frontViewController{
    self  = [super init];
    if (self) {
        self.rearViewController = rearViewController;
        self.frontViewController = frontViewController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self switchController:self.frontViewController];
    [self.containerView addSubview:self.rearViewController.view];
    [self.containerView addSubview:self.frontViewController.view];
    CGRect menuFrame = self.containerView.bounds;
    menuFrame.size.width = MAXMENUWIDTH;
    self.rearViewController.view.frame = menuFrame;
    self.frontViewController.view.frame = self.containerView.frame;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.frontViewController.view addGestureRecognizer:panGestureRecognizer];
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
        NSLog(@"started");
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {

        CGFloat newXPosition = frame.origin.x + (velocity.x)/50;
        if (newXPosition < 0) {
            newXPosition = 0;
        }
        if (newXPosition > MAXMENUWIDTH) {
            newXPosition = MAXMENUWIDTH;
        }
        frame.origin.x = newXPosition;
        //NSLog(@"changed %2f", newXPosition);
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"velocity: %2f", velocity.x);
        CGFloat endPosition;
        if (frame.origin.x > 250 || (frame.origin.x > 135 && velocity.x > 0)) {
            endPosition = MAXMENUWIDTH;
        }else {
            endPosition = 0;
        }
        frame.origin.x = endPosition;

        if (frame.origin.x == 0 && self.selectedViewController == self.rearViewController) {
            [self switchController:self.frontViewController];
        } else if (frame.origin.x == MAXMENUWIDTH && self.selectedViewController == self.frontViewController) {
            [self switchController:self.rearViewController];
        }
    }
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            panGestureRecognizer.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];    
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
    NSLog(@"%@", self.childViewControllers);
}
@end
