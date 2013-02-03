//
//  LocationTests.m
//  LocationTests
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "LocationTests.h"
#import "LocationForTesting.h"
#import "OCMock/OCMock.h"


@implementation LocationTests

@synthesize myLocation;




- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.myLocation = [[Location alloc]init];
    
}

- (void)tearDown
{
    // Tear-down code here.
    self.myLocation = nil;
    [super tearDown];
}

-(void)testInit {
    
    STAssertNotNil(self.myLocation, @"Test object not created");
}

-(void)testInitSetsLocationManager {
    
    STAssertNotNil([self.myLocation myLocationManager], @"Location manger property is nil");
    STAssertTrue([[self.myLocation myLocationManager] isKindOfClass:[CLLocationManager class]], @"LocationManager class should be CLLocationManager");
}

- (void)testCalculateSpeedInMPH
{
    float metersPerMile = 1609.344;
    float secondsPerHour = 60 * 60;
    float mph = [self.myLocation calculateSpeedInMPH:55.0 * metersPerMile / secondsPerHour];
    STAssertTrue(mph == 55.0, @"Calculated speed should be 55 mph but was reported as %f",mph);

}

- (void)testLocationManagerDidUpdateSetsSpeed {
    
    id mock =  (id)[OCMockObject mockForClass:[CLLocation class]];
    NSArray * mocks = [[NSArray alloc] initWithObjects:mock, mock, nil];
    
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)]speed];
  
    [self.myLocation setGeocodePending:YES];
    [self.myLocation locationManager:nil didUpdateLocations:mocks];
    
    double newSpeed = [self.myLocation mySpeed];
    STAssertTrue(newSpeed == 55.0, @"Speed is expected to be 55.0 but %f was returned.", newSpeed);
    
}



@end
