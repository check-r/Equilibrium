//
//  ActivityHistory.m
//  Equilibrium
//
//  Created by Stefan on 22.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "ActivityHistory.h"

@implementation ActivityHistory

@synthesize histActivity,histEnd,histPrimaryKey,histSelected,histStart;
//@synthesize histLastPrimaryKey, activitiesHistory;


/*static ActivityHistory * sharedInstance = nil;



-(id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

+(ActivityHistory *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[ActivityHistory alloc] init];
    }
    return sharedInstance;
}

#pragma mark save/load plist data
-(void) savePlistData {
   
    // Save HistoryDictionary in plist
    //[self writeDictionaryToFile:activitiesHistory toFile:@"userHistoryDictionary.plist"];
    
}

- (void) loadPlistData {
    
    // Init temp Array for fetching data from plist
    NSMutableDictionary * tmpDictionary;
     NSString *plistPath;
    
    // Nimm den Pfad im Filesystem ...
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    // Setze plistPath ...
    plistPath = [rootPath stringByAppendingPathComponent:@"userHistoryDictionary.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // Falls die Datei nicht vorhanden ist nimm default aus dem Bundle...
        plistPath = [[NSBundle mainBundle] pathForResource:@"startHistoryDictionary" ofType:@"plist"];
    }
    tmpDictionary = [self getDictionaryFromFile:plistPath];
    
    // put the dictionary together in an array of class ActivityHistory
    histLastPrimaryKey = [tmpDictionary valueForKey:@"primaryKey"];
     if (![histLastPrimaryKey isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        for (NSString * myKey in tmpDictionary) {
            ActivityHistory * hist = [[ActivityHistory alloc] init];
            if (![myKey isEqualToString:@"primaryKey"]) {
                [hist setHistPrimaryKey:[NSNumber numberWithInteger:[myKey integerValue]]];
                [hist setHistActivity:[myKey valueForKey:@"activity"]];
                [hist setHistSelected:[myKey valueForKey:@"selected"]];
                [hist setHistStart:[myKey valueForKey:@"start"]];
                [hist setHistEnd:[myKey valueForKey:@"end"]];
                if (!activitiesHistory) {
                    activitiesHistory = [[NSMutableArray alloc] init];
                }
                [activitiesHistory insertObject:hist atIndex:0];
                NSLog(@"Objects:%d",activitiesHistory.count);
                NSLog(@"ActivityHistory: %@ %@, %@, %@, %@", hist.histPrimaryKey,hist.histActivity, hist.histSelected, hist.histStart, hist.histEnd);
            }
        }
    }
    NSLog(@"primaryKey:%@",histLastPrimaryKey);
    
    // sortieren nach Sequence...
    NSSortDescriptor * sortSequence = [[NSSortDescriptor alloc] initWithKey:@"histPrimaryKey" ascending:NO];
    NSArray *sortDescriptors = @[sortSequence];
    [activitiesHistory sortUsingDescriptors:sortDescriptors];
    
    
}*/


@end
