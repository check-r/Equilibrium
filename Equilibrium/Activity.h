//
//  Activity.h
//  Equilibrium
//
//  Created by Stefan on 18.01.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic, strong) NSString * actActivity;
@property (nonatomic, strong) NSNumber * actPercent;
@property (nonatomic, strong) NSNumber * actSelected;
@property (nonatomic, strong) NSString * actIcon;
@property (nonatomic, strong) NSString * actSequence;

@property (strong, nonatomic) NSMutableArray * activities;

+(Activity *) sharedInstance;

-(void) savePlistData;
-(void) loadPlistData;


@end
