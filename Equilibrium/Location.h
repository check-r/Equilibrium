//
//  Location.h
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


//#import "LocationForTesting.h" // darf nicht eingebunden werden, error: cannot find interface declaration...


@interface Location : NSObject <CLLocationManagerDelegate>


@property float mySpeed;
@property (nonatomic, strong) CLLocationManager * myLocationManager;
@property (nonatomic, strong) NSString * postalCode;
@property (nonatomic, strong) CLGeocoder * geocoder;
@property (nonatomic, strong) NSString * mySpeedText;

-(void) startLocationUpdates;

-(void)updatePostalCode:(CLLocation *)newLocation
            withHandler:(CLGeocodeCompletionHandler)completitionHandler;




@end
