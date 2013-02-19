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

//-(void) testViewDidLoadSetsLocation {
//    
//    [self.vc viewDidLoad];
//    STAssertNotNil(self.vc, @"Location wasn't set");
//}
//

@end
