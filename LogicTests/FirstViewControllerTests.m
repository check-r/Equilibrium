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




@end
