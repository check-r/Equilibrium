//
//  TrackMeApplicationTests.m
//  TrackMeApplicationTests
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "TrackMeViewController.h"


@interface TrackMeApplicationTests : SenTestCase

@property (nonatomic, weak) TrackMeViewController * trackMeVC;


@end


@implementation TrackMeApplicationTests

@synthesize trackMeVC;


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    UIApplication * application = [UIApplication sharedApplication];
    AppDelegate * appDelegate = [application delegate];
    UIWindow * window = [appDelegate window];
    UITabBarController * tabBar = (UITabBarController *)[window rootViewController];
 
    // load TrackMeViewController
    self.trackMeVC = (TrackMeViewController *)[tabBar.viewControllers objectAtIndex:1];
    [self.trackMeVC loadView];
    [self.trackMeVC viewDidLoad];
}

- (void)tearDown
{
    // Tear-down code here.
    self.trackMeVC = nil;
    [super tearDown];
}




- (void)testThatTrackMeViewControllerIsntNil
{
    STAssertNotNil(self.trackMeVC, @"ViewController is not set");
}


- (void)testThatMapViewIsntNil
{
    STAssertNotNil([self.trackMeVC mapView], @"MapView is not set");
}

-(void) testThatShowsUserLocation {
    
    STAssertTrue(self.trackMeVC.mapView.showsUserLocation == YES, @"ShowsUserLocation not set");
}


-(void) testThatUserTrackingFollow {
    
    STAssertTrue(self.trackMeVC.mapView.userTrackingMode == MKUserTrackingModeFollow, @"UserTrackingMode is not follow");
}

-(void) testThatSpeedLabelOutletIsConnected {
    
    STAssertNotNil(self.trackMeVC.speedLabel, @"speedLabel IBOutlet is not connected");
}


@end
