//
//  ActivitiesHistoryViewController.h
//  Equilibrium
//
//  Created by Stefan on 22.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityHistory.h"
#import <iAd/iAd.h>

@interface ActivitiesHistoryViewController : UITableViewController <ADBannerViewDelegate>

@property (strong, nonatomic) ActivityHistory * hist;

@end
