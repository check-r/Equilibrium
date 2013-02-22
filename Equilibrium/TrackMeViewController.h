//
//  TrackMeViewController.h
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MapKit/MapKit.h>
#import <iAd/iAd.h>
#import "Activity.h"
#import "CurrentActivity.h"

@interface TrackMeViewController : UIViewController <ADBannerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) Location * myLocation;
@property (nonatomic, strong) Activity * myAct;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;

-(void)beginnLocationUpdates:(Location *)myLocation;
-(void)handleLocationChange:(NSNotification *)notification;
-(void)handleMapTap;



@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

//@property (strong, nonatomic) NSMutableArray * objects;

@property (strong, nonatomic) NSTimer * activityTimer;
//@property (strong,nonatomic) NSNumber * primaryKey;
//@property (strong,nonatomic) NSMutableDictionary * myActivitiesHistory;
@property (strong,nonatomic) CurrentActivity * currAct;

//@property (strong, nonatomic) ThirdViewController * viewController3;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
- (IBAction)switched:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *myTextField;
@property (weak, nonatomic) IBOutlet UILabel *myTimerLabel;


@end
