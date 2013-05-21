//
//  MainViewController.h
//  RescuePrincess
//
//  Created by WCG on 13. 5. 20..
//  Copyright (c) 2013년 wcgwcg. All rights reserved.
//

#import "FlipsideViewController.h"
#import "HelpViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>
@property (strong, nonatomic)UIImageView *animationImageView;

- (IBAction)showInfo:(id)sender;
- (IBAction)HelpButtonTouchUpInside:(id)sender;


@end
