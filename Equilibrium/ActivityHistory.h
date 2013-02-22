//
//  ActivityHistory.h
//  Equilibrium
//
//  Created by Stefan on 22.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityHistory : NSObject

@property (strong,nonatomic) NSNumber * histPrimaryKey;
@property (nonatomic, strong) NSString * histActivity;
@property (nonatomic, strong) NSNumber * histSelected;
@property (nonatomic, strong) NSDate * histStart;
@property (nonatomic, strong) NSDate * histEnd;

@property (strong,nonatomic) NSNumber * histLastPrimaryKey;

@property (strong, nonatomic) NSMutableArray * activitiesHistory;

+(ActivityHistory *) sharedInstance;

-(void) savePlistData;
-(void) loadPlistData;



@end
