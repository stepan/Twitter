//
//  ContainerViewController.m
//  Twitter
//
//  Created by Stepan Grigoryan on 4/3/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "ContainerViewController.h"

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

- (id)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController{
    self  = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        self.rightViewController = rightViewController;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.containerView addSubview:self.leftViewController.view];
    [self.containerView addSubview:self.rightViewController.view];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.rightViewController.view addGestureRecognizer:panGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPan:(UIPanGestureRecognizer *)panGestureRecognizer{
    CGFloat endPosition = 280;
    CGPoint velocity = [panGestureRecognizer velocityInView:self.containerView];
    CGRect frame = panGestureRecognizer.view.frame;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"started");
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {

        CGFloat newXPosition = frame.origin.x + (velocity.x)/50;
        if (newXPosition < 0) {
            newXPosition = 0;
        }
        if (newXPosition > endPosition) {
            newXPosition = endPosition;
        }
        frame.origin.x = newXPosition;
        //NSLog(@"changed %2f", newXPosition);
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (frame.origin.x > 250) {
            frame.origin.x = endPosition;
        } else if (frame.origin.x < 100){
            frame.origin.x = 0;
        }
        else {
            if (velocity.x > 0) {
                frame.origin.x = endPosition;
            }
            else{
                frame.origin.x = 0;
            }
        }
        if (frame.origin.x == 0 && self.selectedViewController == self.leftViewController) {
            self.selectedViewController = self.rightViewController;
            [self willMoveToParentViewController:self.leftViewController];
            [self.rightViewController removeFromParentViewController];
            [self addChildViewController:self.rightViewController];
            [self willMoveToParentViewController:self.rightViewController];
        } else if (frame.origin.x == endPosition && self.selectedViewController == self.rightViewController) {
            self.selectedViewController = self.leftViewController;
            [self willMoveToParentViewController:self.rightViewController];
            [self.leftViewController removeFromParentViewController];
            [self addChildViewController:self.leftViewController];
            [self willMoveToParentViewController:self.leftViewController];
            
        }
    }
    panGestureRecognizer.view.frame = frame;
    return;
    UIView *view = panGestureRecognizer.view;
    [self addChildViewController:self.leftViewController];
    NSLog(@"%@", view);
    frame.origin.x += 2;
    view.frame = frame;
    
}
@end
