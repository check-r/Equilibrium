//
//  FirstViewController.h
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MapKit/MapKit.h>


@interface FirstViewController : UIViewController

@property (nonatomic, strong) Location * location;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
