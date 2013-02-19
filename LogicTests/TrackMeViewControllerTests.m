//
//  TrackMeViewControllerTests.m
//  Equilibrium
//
//  Created by Stefan on 06.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "TrackMeViewController.h"



@interface TrackMeViewControllerTests : SenTestCase

@property (nonatomic, strong) TrackMeViewController * tmvc;


@end



@implementation TrackMeViewControllerTests

@synthesize tmvc;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.tmvc = [[TrackMeViewController alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.tmvc = nil;
    [super tearDown];
}


-(void) testTrackMeViewControllerCreated {
    
    STAssertNotNil(self.tmvc, @"TrackMeViewController not created");
}

-(void) testViewDidLoadSetsLocation {
    
    [self.tmvc viewDidLoad];
    STAssertNotNil([self.tmvc myLocation], @"Location wasn't set");
}


-(void) testViewDidLoadCallsBeginnLocationUpdates {
    
    id mockFVC = [OCMockObject partialMockForObject:self.tmvc];
    [[mockFVC expect] beginnLocationUpdates:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC verify];
}

-(void) testBeginnLocationUpdates {
    
    id mock = [OCMockObject mockForClass:[Location class]];
    [[mock expect] startLocationUpdates];
    [self.tmvc beginnLocationUpdates:mock];
    [mock verify];
}

-(void) testViewDidLoadSetsUserTrackingMode {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow];
    [self.tmvc setMapView:(MKMapView *)mock];
    [self.tmvc viewDidLoad];
    [mock verify];
}

-(void) testLocationChangeNotificationUpdatesSpeed {
    
    id locationMock = [OCMockObject mockForClass:[Location class]];
    [(Location *)[[locationMock stub] andReturn:@"55 MPH"] mySpeedText];
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    [[[notificationMock stub] andReturn:(Location *)locationMock] object];
    
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"55 MPH"];
    
    [self.tmvc setSpeedLabel:labelMock];
    
    [self.tmvc handleLocationChange:(NSNotification *)notificationMock];
    
    [labelMock verify];
}

-(void) testThatNotificationHandlerCalled {
    
    id mockFVC = [OCMockObject partialMockForObject:self.tmvc];
    [[mockFVC expect] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testThatNotificationHandlerNotCalledAfterUnload {
    
    id mockFVC = [OCMockObject partialMockForObject:self.tmvc];
    [[mockFVC reject] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC viewDidUnload];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testTapGestureHandlerSetsUserTrackingModeFollow {
    
    id mock = [OCMockObject mockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.tmvc setMapView:(MKMapView *)mock];
    [self.tmvc handleMapTap];
    [mock verify];
}


-(void) testViewDidLoadSetsMapGestureRecognizer {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] addGestureRecognizer:[OCMArg any]];
    [self.tmvc setMapView:(MKMapView *)mock];
    [self.tmvc viewDidLoad];
    [mock verify];
}

@end
