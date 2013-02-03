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
    self.vc = (FirstViewController *)[window rootViewController];
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

//
//- (void)testThatMapViewIsntNil
//{
//    // funzt so irgendwie nicht 
//    STAssertNotNil([self.vc mapView], @"View is not set");
//    
//}


@end
