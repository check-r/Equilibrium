//
//  VCTrackMe.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "VCTrackMe.h"

@interface VCTrackMe ()

@end

@implementation VCTrackMe

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationChange:) name:@"LocationChange" object:nil];
    UITapGestureRecognizer * mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap)];
    [self.mapView addGestureRecognizer:mapTap];
    
    self.mapView.showsUserLocation = YES;  // set in nib also possible, or must be used with niceMocks when set in viewDidLoad
}


-(void) viewDidUnload {
    
    [self setMapView:nil];
    [self setSpeedLabel:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    self.myLocation = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification Handler


-(void)handleLocationChange:(NSNotification *)notification {
    
    Location * location = [notification object];
    NSString * speed = [location mySpeedText];
    [self.speedLabel setText:speed];
    
}

#pragma mark - Tap Handler

-(void)handleMapTap {
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}

@end
