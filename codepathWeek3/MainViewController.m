//
//  MainViewController.m
//  codepathWeek3
//
//  Created by Michael Wang on 6/28/14.
//  Copyright (c) 2014 mkwng. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *storiesView;
@property (weak, nonatomic) IBOutlet UIScrollView *newsScrollView;

- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecognizer;


@end

@implementation MainViewController

CGPoint touchBeginPoint;
CGPoint initialPoint;
CGPoint viewBeginPoint;

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
    // Do any additional setup after loading the view from its nib.
    self.newsScrollView.contentSize = CGSizeMake(1444, 253);
    initialPoint = self.storiesView.center;
    UIPanGestureRecognizer *globalGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGlobal:)];
    
    [self.view addGestureRecognizer:(UIGestureRecognizer *)globalGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint)newYvalue:(CGPoint)location
{
    
    return location;
}



- (void)onPanGlobal:(UIPanGestureRecognizer *)panGestureRecognizer
{
    
    
    CGPoint touchCurrentPoint = [panGestureRecognizer locationInView:self.view];
    CGPoint moveToPoint = initialPoint;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        touchBeginPoint = [panGestureRecognizer locationInView:self.view];
        viewBeginPoint = self.storiesView.center;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat newY = viewBeginPoint.y + (touchCurrentPoint.y - touchBeginPoint.y);
        moveToPoint = CGPointMake(initialPoint.x, newY);
        self.storiesView.center = moveToPoint;
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat delta = touchCurrentPoint.y - touchBeginPoint.y;
        
        if (delta<0) {
            moveToPoint = initialPoint;
        }
        else {
            moveToPoint = CGPointMake(initialPoint.x,800);
        }
        
        [UIView
         animateWithDuration:.6
         delay:0
         usingSpringWithDamping:.8
         initialSpringVelocity:1
         options:0
         animations:^{
             self.storiesView.center = moveToPoint;
         }
         completion:nil
         ];
        
    }

}
@end
