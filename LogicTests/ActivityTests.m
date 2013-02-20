//
//  ActivityTests.m
//  Equilibrium
//
//  Created by Stefan on 19.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "OCMock/OCMock.h"
#import "Activity.h"



@interface ActivityTests : SenTestCase

@property (nonatomic, strong) Activity * myTestActivity;

@end


@implementation ActivityTests

@synthesize myTestActivity;


#pragma mark - setUp and tearDown Logic Tests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.myTestActivity = [[Activity alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.myTestActivity = nil;
    [super tearDown];
}

#pragma mark - OCUnit and OCMock Tests

-(void) testOCMockIsWorking {
    
    id mock = (id)[OCMockObject mockForClass:[NSObject class]];
    STAssertNotNil(mock, @"Mock object not created");
}

-(void)testInit {
    
    STAssertNotNil(self.myTestActivity, @"Test object not created");
}

-(void) testSharedInstance {
    
    STAssertNotNil([Activity sharedInstance], @"Shared Instance not created");
}

-(void) testSharedInstanceReturnsSameObject {
    
    Activity * act1 = [Activity sharedInstance];
    Activity * act2 = [Activity sharedInstance];
    
    STAssertEqualObjects(act1, act2, @"Shared Instances are not the same object");
}


@end
