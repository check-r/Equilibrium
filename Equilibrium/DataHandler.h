//
//  DataHandler.h
//  Equilibrium
//
//  Created by Stefan on 23.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"
#import "ActivityHistory.h"

@interface DataHandler : NSObject

@property (strong, nonatomic) NSMutableArray * activities;

@property (strong,nonatomic) NSNumber * histLastPrimaryKey;
@property (strong, nonatomic) NSMutableArray * activitiesHistory;

+(DataHandler *) sharedInstance;

-(void) savePlistData;
-(void) loadPlistData;


@end
