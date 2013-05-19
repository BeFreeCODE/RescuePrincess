//
//  DetailViewController.h
//  Test
//
//  Created by doouky on 13. 5. 19..
//  Copyright (c) 2013년 FreeCODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
