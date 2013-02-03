//
//  LocationForTesting.h
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "Location.h"

@interface Location()

@property BOOL geocodePending;

-(float) calculateSpeedInMPH:(float)speedInMetersPerSecond;


@end
