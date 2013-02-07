//
//  Location.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

//#import "Location.h"  // muss nich mehr eingebunden werden, da schon in LocationForTesting eingebunden
#import "LocationForTesting.h"



@implementation Location


@synthesize myLocationManager, mySpeed, mySpeedText, postalCode, geocoder, geocodePending;

-(id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    postalCode = @"unknown";
    geocodePending = NO;
    geocoder = [[CLGeocoder alloc]init];
    mySpeedText = @"Calculating...";
    
    myLocationManager = [[CLLocationManager alloc]init];
    [myLocationManager setDelegate:self];
    [myLocationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [myLocationManager setDistanceFilter:kCLDistanceFilterNone];
    
    return self;
}

-(void)startLocationUpdates {
    
    [[self myLocationManager] startUpdatingLocation];
}

#pragma mark - Helper methods

-(void)updatePostalCode:(CLLocation *)newLocation
            withHandler:(CLGeocodeCompletionHandler)completitionHandler {
    
    if (geocodePending == YES) {
        return;
    }
    geocodePending = YES;
    [[self geocoder]reverseGeocodeLocation:newLocation
                         completionHandler:completitionHandler];
}


-(float)calculateSpeedInMPH:(float)speedInMetersPerSecond {

    float speedInMetersPerHour = speedInMetersPerSecond * 60 * 60;
    return speedInMetersPerHour / 1609.344;
}


#pragma mark - Location Delegate methods

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations {
    
    // new for iOS 6.1
    int lastLocation = [locations count] -1;
    CLLocation * newLocation = locations[lastLocation];
    
    [self updatePostalCode:newLocation
               withHandler:^(NSArray *placemarks, NSError *error){
                   CLPlacemark *placemark = [placemarks objectAtIndex:0];
                   [self setPostalCode:[placemark postalCode]];
                   NSLog(@"%@",self.postalCode);
                   geocodePending = NO;
               }];
    
    
    float speed = [self calculateSpeedInMPH:[newLocation speed]];
    mySpeed = speed;
    mySpeedText = [NSString stringWithFormat:@"%.0f MPH", mySpeed];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationChange" object:self];
    
}


@end
