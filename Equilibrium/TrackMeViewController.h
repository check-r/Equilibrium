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
#import "ActivityHistory.h"
#import "CurrentActivity.h"

@interface TrackMeViewController : UIViewController <ADBannerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) Location * myLocation;
@property (nonatomic, strong) Activity * myAct;
@property (nonatomic, strong) ActivityHistory * myHist;
@property (strong,nonatomic) CurrentActivity * currAct;
@property (strong, nonatomic) NSTimer * activityTimer;


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;


@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UITextView *myTextField;
@property (weak, nonatomic) IBOutlet UILabel *myTimerLabel;

- (IBAction)switched:(id)sender;

-(void)beginnLocationUpdates:(Location *)myLocation;
-(void)handleLocationChange:(NSNotification *)notification;
-(void)handleMapTap;


@end
