//
//  ApplicationTests.m
//  ApplicationTests
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "ApplicationTests.h"


@implementation ApplicationTests

@synthesize vc;


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    UIApplication * application = [UIApplication sharedApplication];
    AppDelegate * appDelegate = [application delegate];
    UIWindow * window = [appDelegate window];
    UITabBarController * tabBar = (UITabBarController *)[window rootViewController];
    self.vc = (FirstViewController *)[tabBar.viewControllers objectAtIndex:0];
}

- (void)tearDown
{
    // Tear-down code here.
    self.vc = nil;
    [super tearDown];
}

- (void)testThatFirstViewControllerIsntNil
{
    STAssertNotNil(self.vc, @"ViewController is not set");
}


- (void)testThatMapViewIsntNil
{
    //self.map = self.vc.mapView;
    STAssertNotNil(self.vc.mapView, @"MapView is not set");
}

-(void) testThatShowsUserLocation {
    
    STAssertTrue(self.vc.mapView.showsUserLocation == YES, @"ShowsUserLocation not set");
}

-(void) testThatUserTrackingFollow {
    
    STAssertTrue(self.vc.mapView.userTrackingMode == MKUserTrackingModeFollow, @"UserTrackingMode is not follow");
}

-(void) testThatSpeedLabelOutletIsConnected {
    
    STAssertNotNil(self.vc.speedLabel, @"speedLabel IBOutlet is not connected");
}


@end
