//
//  LocationGHAsyncTests.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "LocationForTesting.h"



@interface LocationGHAsyncTests : GHAsyncTestCase { }
@end

@implementation LocationGHAsyncTests

- (void)testUpdatePostalCode {
    
    [self prepare];
    
    Location *location = [[Location alloc]init];
    [location updatePostalCode:nil
                   withHandler:^(NSArray *placemarks, NSError *error){
                       [self notify:kGHUnitWaitStatusSuccess
                        forSelector:@selector(testUpdatePostalCode)];
                   }];
    
    GHAssertTrue([location geocodePending]==YES, @"geocodePending should be true");
    [self waitForStatus:kGHUnitWaitStatusSuccess
                timeout:5.0];
    
}


@end