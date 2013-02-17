//
//  VCTrackMe.h
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MapKit/MapKit.h>


@interface VCTrackMe : UIViewController

@property (nonatomic, strong) Location * myLocation;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;

-(void)beginnLocationUpdates:(Location *)myLocation;
-(void)handleLocationChange:(NSNotification *)notification;
-(void)handleMapTap;

@end
