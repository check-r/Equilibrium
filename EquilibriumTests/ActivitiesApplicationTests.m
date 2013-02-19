//
//  ActivitiesApplicationTests.m
//  ActivitiesApplicationTests
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "ActivitiesViewController.h"




@interface ActivitiesApplicationTests : SenTestCase

@property (nonatomic, weak) ActivitiesViewController * activitiesVC;

@end


@implementation ActivitiesApplicationTests

@synthesize activitiesVC;


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    UIApplication * application = [UIApplication sharedApplication];
    AppDelegate * appDelegate = [application delegate];
    UIWindow * window = [appDelegate window];
    UITabBarController * tabBar = (UITabBarController *)[window rootViewController];
    self.activitiesVC = (ActivitiesViewController *)[tabBar.viewControllers objectAtIndex:0];
//    [self.activitiesVC loadView];
//    [self.activitiesVC viewDidLoad];
}

- (void)tearDown
{
    // Tear-down code here.
    self.activitiesVC = nil;
    [super tearDown];
}


- (void)testThatActivitiesViewControllerIsntNil
{
    STAssertNotNil(self.activitiesVC, @"ViewController is not set");
}

@end
