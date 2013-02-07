//
//  FirstViewController.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize myLocation, mapView;


#pragma mark - View Lifecycle

- (void)beginnLocationUpdates:(Location *)location
{
    [location startLocationUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.myLocation = [[Location alloc]init];
    [self beginnLocationUpdates:self.myLocation];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;

//    self.mapView.showsUserLocation = YES;  // set in nib also possible
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
