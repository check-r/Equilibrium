//
//  FirstViewControllerTests.m
//  Equilibrium
//
//  Created by Stefan on 06.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "VCTrackMe.h"



@interface FirstViewControllerTests : SenTestCase

@property (nonatomic, strong) VCTrackMe * fvc;


@end



@implementation FirstViewControllerTests

@synthesize fvc;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.fvc = [[VCTrackMe alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.fvc = nil;
    [super tearDown];
}


-(void) testFirstViewControllerCreated {
    
    STAssertNotNil(self.fvc, @"FirstViewController not created");
}

-(void) testViewDidLoadSetsLocation {
    
    [self.fvc viewDidLoad];
    STAssertNotNil(self.fvc, @"Location wasn't set");
}


-(void) testViewDidLoadCallsBeginnLocationUpdates {
    
    id mockFVC = [OCMockObject partialMockForObject:self.fvc];
    [[mockFVC expect] beginnLocationUpdates:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC verify];
}

-(void) testBeginnLocationUpdates {
    
    id mock = [OCMockObject mockForClass:[Location class]];
    [[mock expect] startLocationUpdates];
    [self.fvc beginnLocationUpdates:mock];
    [mock verify];
}

-(void) testViewDidLoadSetsUserTrackingMode {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow];
    [self.fvc setMapView:(MKMapView *)mock];
    [self.fvc viewDidLoad];
    [mock verify];
}

-(void) testLocationChangeNotificationUpdatesSpeed {
    
    id locationMock = [OCMockObject mockForClass:[Location class]];
    [(Location *)[[locationMock stub] andReturn:@"55 MPH"] mySpeedText];
    id notificationMock = [OCMockObject mockForClass:[NSNotification class]];
    [[[notificationMock stub] andReturn:(Location *)locationMock] object];
    
    id labelMock = [OCMockObject mockForClass:[UILabel class]];
    [[labelMock expect] setText:@"55 MPH"];
    
    [self.fvc setSpeedLabel:labelMock];
    
    [self.fvc handleLocationChange:(NSNotification *)notificationMock];
    
    [labelMock verify];
}

-(void) testThatNotificationHandlerCalled {
    
    id mockFVC = [OCMockObject partialMockForObject:self.fvc];
    [[mockFVC expect] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testThatNotificationHandlerNotCalledAfterUnload {
    
    id mockFVC = [OCMockObject partialMockForObject:self.fvc];
    [[mockFVC reject] handleLocationChange:[OCMArg any]];
    [mockFVC viewDidLoad];
    [mockFVC viewDidUnload];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:nil];
    [mockFVC verify];
}

-(void) testTapGestureHandlerSetsUserTrackingModeFollow {
    
    id mock = [OCMockObject mockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.fvc setMapView:(MKMapView *)mock];
    [self.fvc handleMapTap];
    [mock verify];
}


-(void) testViewDidLoadSetsMapGestureRecognizer {
    
    id mock = [OCMockObject niceMockForClass:[MKMapView class]];
    [[mock expect] addGestureRecognizer:[OCMArg any]];
    [self.fvc setMapView:(MKMapView *)mock];
    [self.fvc viewDidLoad];
    [mock verify];
}

@end
