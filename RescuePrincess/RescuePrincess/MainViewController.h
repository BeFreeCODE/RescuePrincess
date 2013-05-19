//
//  MainViewController.h
//  RescuePrincess
//
//  Created by 오 준영 on 13. 5. 17..
//  Copyright (c) 2013년 오 준영. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)showInfo:(id)sender;

@end
