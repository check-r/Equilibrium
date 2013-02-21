//
//  CurrentActivity.h
//  Equi-Tabbed
//
//  Created by Stefan on 28.01.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentActivity : NSObject

@property (nonatomic, strong) NSString * activity;
@property (nonatomic, strong) NSDate * start;
@property (nonatomic, strong) NSDate * ende;
@property (nonatomic, strong) NSNumber * selected;

@end
