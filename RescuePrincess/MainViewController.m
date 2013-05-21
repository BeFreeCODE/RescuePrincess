//
//  MainViewController.m
//  RescuePrincess
//
//  Created by WCG on 13. 5. 20..
//  Copyright (c) 2013년 wcgwcg. All rights reserved.
//

#import "MainViewController.h"
#import "HelpViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize animationImageView = _animationImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.animationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NextImage"]];
    [_animationImageView setFrame:[[UIScreen mainScreen] bounds]];
    [_animationImageView setAlpha:1.0f];
    [self.view addSubview:_animationImageView];
    
    [UIView animateWithDuration:1.0f
                     animations:^{[_animationImageView setAlpha:1.0f];}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0f
                                          animations:^{
                                              [_animationImageView setAlpha:0.0f];
                                          }
                                          completion:^(BOOL finished){
                                              [_animationImageView removeFromSuperview];
                                              self.animationImageView = nil;
                                          }];
                     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)HelpButtonTouchUpInside:(id)sender {
    HelpViewController *HelpView = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
    HelpView.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:HelpView animated:YES completion:nil];
    
}

@end
