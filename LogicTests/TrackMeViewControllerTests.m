//
//  FirstViewControllerTests.m
//  Equilibrium
//
//  Created by Stefan on 06.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "TrackMeViewController.h"



@interface TrackMeViewControllerTests : SenTestCase

@property (nonatomic, strong) TrackMeViewController * vc;


@end



@implementation TrackMeViewControllerTests

@synthesize vc;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.vc = [[TrackMeViewController alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.vc = nil;
    [super tearDown];
}


-(void) testFirstViewControllerCreated {
    
    STAssertNotNil(self.vc, @"FirstViewController not created");
}

-(void) testViewDidLoadSetsLocation {
    
    [self.vc viewDidLoad];
    STAssertNotNil(self.vc, @"Location wasn't set");
}


-(void) testViewDidLoadCallsBeginnLocationUpdates {
    
    id mockFVC = [OCMockObject partialMockForObject:self.vc];
    [[mockFVC expect] beginnLocationUpdates:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC verify];
}

-(void) testBeginnLocationUpdates {
    
    id mock = [OCMockObject mockForClass:[Location class]];
    [[mock expect] startLocationUpdates];
    [self.vc beginnLocationUpdates:mock];
    [mock verify];
}

-(void) testViewDidLoadSetsUserTrackingMode {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow];
    [self.vc setMapView:(MKMapView *)mock];
    [self.vc viewDidLoad];
    [mock verify];
}

-(void) testLocationChangeNotificationUpdatesSpeed {
    
    id locationMock = [OCMockObject mockForClass:[Location class]];
    [(Location *)[[locationMock stub] andReturn:@"55 MPH"] mySpeedText];
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    [[[notificationMock stub] andReturn:(Location *)locationMock] object];
    
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"55 MPH"];
    
    [self.vc setSpeedLabel:labelMock];
    
    [self.vc handleLocationChange:(NSNotification *)notificationMock];
    
    [labelMock verify];
}

-(void) testThatNotificationHandlerCalled {
    
    id mockFVC = [OCMockObject partialMockForObject:self.vc];
    [[mockFVC expect] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testThatNotificationHandlerNotCalledAfterUnload {
    
    id mockFVC = [OCMockObject partialMockForObject:self.vc];
    [[mockFVC reject] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC viewDidUnload];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testTapGestureHandlerSetsUserTrackingModeFollow {
    
    id mock = [OCMockObject mockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.vc setMapView:(MKMapView *)mock];
    [self.vc handleMapTap];
    [mock verify];
}


-(void) testViewDidLoadSetsMapGestureRecognizer {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] addGestureRecognizer:[OCMArg any]];
    [self.vc setMapView:(MKMapView *)mock];
    [self.vc viewDidLoad];
    [mock verify];
}

@end
