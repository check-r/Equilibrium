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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationChange:) name:@"LocationChange" object:nil];
    
//    self.mapView.showsUserLocation = YES;  // set in nib also possible
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

-(void)handleLocationChange:(NSNotification *)notification {
    
    Location * location = [notification object];
    NSString * speed = [location mySpeedText];
    [self.speedLabel setText:speed];
    
}

@end
