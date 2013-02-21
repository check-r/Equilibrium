//
//  ActivitiesViewController.h
//  Equilibrium
//
//  Created by Stefan on 18.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import <iAd/iAd.h>



@interface ActivitiesViewController : UITableViewController <ADBannerViewDelegate>

@property (nonatomic, strong) Activity * act;

-(void)startLoadingPlistData:(Activity *)activityObject;

@end
