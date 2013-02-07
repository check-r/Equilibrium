//
//  FirstViewControllerTests.m
//  Equilibrium
//
//  Created by Stefan on 06.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "FirstViewController.h"



@interface FirstViewControllerTests : SenTestCase

@property (nonatomic, strong) FirstViewController * fvc;


@end



@implementation FirstViewControllerTests

@synthesize fvc;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.fvc = [[FirstViewController alloc]init];
    
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
    
    id mock = [OCMockObject mockForClass:[MKMapView class]];
    [[mock expect] setUserTrackingMode:MKUserTrackingModeFollow];
    [self.fvc setMapView:(MKMapView *)mock];
    [self.fvc viewDidLoad];
    [mock verify];
}


@end
