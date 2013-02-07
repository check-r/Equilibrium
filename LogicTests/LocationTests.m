//
//  LocationTests.m
//  LocationTests
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//


#import "LocationForTesting.h"
#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "Location.h"


@interface LocationTests : SenTestCase

@property (nonatomic, strong) Location * myLocation;



@end


@implementation LocationTests

@synthesize myLocation;


#pragma mark - setUp and tearDown Logic Tests

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

#pragma mark - OCUnit and OCMock Tests

-(void) testOCMockIsWorking {
    
    id mock = (id)[OCMockObject mockForClass:[NSObject class]];
    STAssertNotNil(mock, @"Mock object not created");
}


-(void)testInit {
    
    STAssertNotNil(self.myLocation, @"Test object not created");
}


-(void) testInitSetsPostalCode {
    NSString * pcode = myLocation.postalCode;
    STAssertTrue([pcode isEqualToString:@"unknown"], @"Postal code should be unknown but is %@", pcode);
}

-(void) testInitSetsGeocodePendingNo {
    
    STAssertFalse(myLocation.geocodePending, @"geocodePending should be NO");
}

-(void) testInitSetsGeocoder {
    
    STAssertNotNil(myLocation.geocoder, @"geocoder is not set");
}


-(void)testInitSetsLocationManager {
    
    STAssertNotNil([self.myLocation myLocationManager], @"Location manger property is nil");
    STAssertTrue([[self.myLocation myLocationManager] isKindOfClass:[CLLocationManager class]], @"LocationManager class should be CLLocationManager");
}

-(void) testInitSetsLocationManagerDelegate {
    
    STAssertTrue(myLocation.myLocationManager.delegate == myLocation, @"LocationManager's delegate should be myLocation object");
}

-(void) testInitSetsLocationMangerProperties {
    
    STAssertEquals(myLocation.myLocationManager.desiredAccuracy, kCLLocationAccuracyBestForNavigation, @"Location Manager desiredAccuracy property not set correctly");
    
    STAssertEquals(myLocation.myLocationManager.distanceFilter, kCLDistanceFilterNone, @"Location Manager distanceFilter property not set correctly");
}

-(void) testStartLocationUpdates {
    
    id mock = [OCMockObject mockForClass:[CLLocationManager class]];
    [[mock expect] startUpdatingLocation];
    [myLocation setMyLocationManager:mock];
    [myLocation startLocationUpdates];
    [mock verify];
}

-(void) testUpdatePostalCodeCallsReverseGeocodeWhenPendingNo {
    
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];

    [myLocation setGeocodePending:NO];
    [[mock expect] reverseGeocodeLocation:nil
                        completionHandler:nil];
    [myLocation setGeocoder:(CLGeocoder *)mock];
    [myLocation updatePostalCode:nil
                     withHandler:nil];
    [mock verify];
}

-(void) testUpdatePostalCodeDoesNotCallsReverseGeocodeWhenPendingYes {
    
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];
    [myLocation setGeocodePending:YES];
    [myLocation setGeocoder:(CLGeocoder *)mock];
    [myLocation updatePostalCode:nil
                     withHandler:nil];
    [mock verify];
}

-(void) testUpdatePostalCodeSetsPending {
    
    id mock = (id)[OCMockObject mockForClass:[CLGeocoder class]];
    [[mock expect] reverseGeocodeLocation:nil
                        completionHandler:nil];
    [myLocation setGeocoder:(CLGeocoder *)mock];
    [myLocation updatePostalCode:nil
                     withHandler:nil];
    STAssertTrue([myLocation geocodePending], @"geocodePending should have beed set");
}


- (void)testCalculateSpeedInMPH
{
    float metersPerMile = 1609.344;
    float secondsPerHour = 60 * 60;
    float mph = [self.myLocation calculateSpeedInMPH:55.0 * metersPerMile / secondsPerHour];
    STAssertTrue(mph == 55.0, @"Calculated speed should be 55 mph but was reported as %f",mph);
}



- (void)testLocationManagerDidUpdateSetsSpeed {
    
    // create mock object as array for iOS 6.1 compatibility
    // type is id
    // the mock fakes as an object for the CLLocation class
    id mock =  (id)[OCMockObject mockForClass:[CLLocation class]];
    NSArray * mocks = [[NSArray alloc] initWithObjects:mock, mock, nil];
    
    // create stub for the speed property of the mock object
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    // cast id type to CLLocation
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)]speed];
  
    [self.myLocation setGeocodePending:YES];
    [self.myLocation locationManager:nil didUpdateLocations:mocks];
    
    double newSpeed = [self.myLocation mySpeed];
    STAssertTrue(newSpeed == 55.0, @"Speed is expected to be 55.0 but %f was returned.", newSpeed);
    
}

- (void)testLocationManagerDidUpdateUpdatespostalCode {
    
    // create mock object as array for iOS 6.1 compatibility
    // type is id
    // the mock fakes as an object for the CLLocation class
    id mock =  (id)[OCMockObject mockForClass:[CLLocation class]];
    NSArray * mocks = [[NSArray alloc] initWithObjects:mock, mock, nil];
    
    // create stub for the speed property of the mock object
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    // cast id type to CLLocation
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)]speed];
    
    // create partial mock
    id mockSelf = [OCMockObject partialMockForObject:myLocation];
    [[mockSelf expect] updatePostalCode:[OCMArg any]
                            withHandler:[OCMArg any]];
    [mockSelf locationManager:nil
           didUpdateLocations:mocks];
    [mockSelf verify];
}


- (void)testLocationManagerDidUpdateNotification {
    
    id mockObserver = [OCMockObject observerMock];
    [[NSNotificationCenter defaultCenter] addMockObserver:mockObserver name:@"LocationChange" object:nil];
    [[mockObserver expect] notificationWithName:@"LocationChange" object:[OCMArg any]];
    
    id mock =  (id)[OCMockObject mockForClass:[CLLocation class]];
    NSArray * mocks = [[NSArray alloc] initWithObjects:mock, mock, nil];
    
    // create stub for the speed property of the mock object
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    // cast id type to CLLocation
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)]speed];
    
    [self.myLocation setGeocodePending:YES];
    [self.myLocation locationManager:nil didUpdateLocations:mocks];
    
    [mockObserver verify];
    [[NSNotificationCenter defaultCenter] removeObserver:mockObserver];
    
}

- (void)testSpeedText {
    
    id mock =  (id)[OCMockObject mockForClass:[CLLocation class]];
    NSArray * mocks = [[NSArray alloc] initWithObjects:mock, mock, nil];
    
    // create stub for the speed property of the mock object
    double metersPerMile = 1609.344;
    double secondsPerHour = 60 * 60;
    double metersPerSecond = 55.0 * metersPerMile / secondsPerHour;
    // cast id type to CLLocation
    [(CLLocation *)[[mock stub] andReturnValue:OCMOCK_VALUE(metersPerSecond)]speed];
    
    [self.myLocation setGeocodePending:YES];
    [self.myLocation locationManager:nil didUpdateLocations:mocks];
    
    NSString * speedText = [self.myLocation mySpeedText];
    STAssertTrue([speedText isEqualToString:@"55 MPH"], @"Speed is expected to be 55 but was %@",speedText);
    
    

}


@end
