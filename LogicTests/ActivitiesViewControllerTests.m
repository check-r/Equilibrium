//
//  ActivitiesViewControllerTests.m
//  Equilibrium
//
//  Created by Stefan on 19.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "ActivitiesViewController.h"



@interface ActivitiesViewControllerTests : SenTestCase

@property (nonatomic, strong) ActivitiesViewController * actvc;


@end


@implementation ActivitiesViewControllerTests


@synthesize actvc;

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.actvc = [[ActivitiesViewController alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.actvc = nil;
    [super tearDown];
}


-(void) testTrackMeViewControllerCreated {
    
    STAssertNotNil(self.actvc, @"ActivitiesViewController not created");
}

-(void) testViewDidLoadSetsActivityReference {
    
    [self.actvc viewDidLoad];
    STAssertNotNil([self.actvc act], @"Activity reference  not set");
}


-(void) testViewDidLoadCallsStartLoadingPlistData {
    
    id mockVC = [OCMockObject partialMockForObject:self.actvc];
    [[mockVC expect] startLoadingPlistData:[OCMArg any]];
    [mockVC viewDidLoad];
    [mockVC verify];
}

-(void) testStartLoadingPlistData {
    
    id mock = [OCMockObject mockForClass:[Activity class]];
    [[mock expect] loadPlistData];
    [self.actvc startLoadingPlistData:mock];
    [mock verify];
}


@end
