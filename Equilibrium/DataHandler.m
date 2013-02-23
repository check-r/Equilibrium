//
//  DataHandler.m
//  Equilibrium
//
//  Created by Stefan on 23.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "DataHandler.h"

@implementation DataHandler

@synthesize activities, activitiesHistory, histLastPrimaryKey;

static DataHandler * sharedInstance = nil;



-(id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

+(DataHandler *) sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[DataHandler alloc] init];
    }
    return sharedInstance;
}

#pragma mark save/load plist data

- (void) savePlistData{
    
    NSMutableDictionary * tmpDictionary = [[NSMutableDictionary alloc] init];
    
    // Save Percentages in plist
    for (Activity * tmp in activities) {
        NSLog(@"saved: %@, %@",[tmp actPercent],[tmp actActivity] );
        [tmpDictionary setValue:[tmp actPercent] forKey:[tmp actActivity]];
    }
    [self writeDictionaryToFile:tmpDictionary toFile:@"userActivitiesPercentages.plist"];
    
    // Save Icons in plist
    for (Activity * tmp in activities) {
        NSLog(@"saved: %@, %@",[tmp actIcon],[tmp actActivity] );
        [tmpDictionary setValue:[tmp actIcon] forKey:[tmp actActivity]];
    }
    [self writeDictionaryToFile:tmpDictionary toFile:@"userActivitiesIcons.plist"];
    
    // Save selcted in plist
    for (Activity * tmp in activities) {
        NSLog(@"saved: %@, %@",[tmp actSelected],[tmp actActivity] );
        [tmpDictionary setValue:[tmp actSelected] forKey:[tmp actActivity]];
    }
    [self writeDictionaryToFile:tmpDictionary toFile:@"userActivitiesSelected.plist"];
    
    // Save sequence in plist
    int sequence = 0;
    for (Activity * tmp in activities) {
        NSLog(@"saved: %i, %@",sequence,[tmp actActivity] );
        [tmpDictionary setValue:[[NSNumber alloc] initWithInt:sequence] forKey:[tmp actActivity]];
        sequence++;
    }
    [self writeDictionaryToFile:tmpDictionary toFile:@"userActivitiesSequence.plist"];
    
    // Save HistoryDictionary in plist
    //[self writeDictionaryToFile:activitiesHistory toFile:@"userHistoryDictionary.plist"];

}

- (void) loadPlistData {
    
    // Init temp Arrays for fetching data from plists
    NSMutableDictionary * myActIcons;
    NSMutableDictionary * myActPercentages;
    NSMutableDictionary * myActSelected;
    NSMutableDictionary * myActSequence;
    NSString *plistPath;
    
    // Nimm den Pfad im Filesystem ...
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    // Setze plistPath für Icons ...
    plistPath = [rootPath stringByAppendingPathComponent:@"userActivitiesIcons.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // Falls die Datei nicht vorhanden ist nimm default aus dem Bundle...
        plistPath = [[NSBundle mainBundle] pathForResource:@"ActivitiesIcons" ofType:@"plist"];
    }
    myActIcons = [self getDictionaryFromFile:plistPath];
    
    // Setze plistPath für Percentages ...
    plistPath = [rootPath stringByAppendingPathComponent:@"userActivitiesPercentages.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // Falls die Datei nicht vorhanden ist nimm default aus dem Bundle...
        plistPath = [[NSBundle mainBundle] pathForResource:@"ActivitiesPercentages" ofType:@"plist"];
    }
    myActPercentages = [self getDictionaryFromFile:plistPath];
    
    // Setze plistPath für Selected ...
    plistPath = [rootPath stringByAppendingPathComponent:@"userActivitiesSelected.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // Falls die Datei nicht vorhanden ist nimm default aus dem Bundle...
        plistPath = [[NSBundle mainBundle] pathForResource:@"ActivitiesSelected" ofType:@"plist"];
    }
    myActSelected = [self getDictionaryFromFile:plistPath];
    
    // Setze plistPath für Sequence ...
    plistPath = [rootPath stringByAppendingPathComponent:@"userActivitiesSequence.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        // Falls die Datei nicht vorhanden ist nimm default aus dem Bundle...
        plistPath = [[NSBundle mainBundle] pathForResource:@"ActivitiesSequence" ofType:@"plist"];
    }
    myActSequence = [self getDictionaryFromFile:plistPath];
    
    // put the arrays together in an array of class Activity
    for (NSString * myKey in myActIcons) {
        Activity * act = [[Activity alloc] init];
        [act setActActivity:myKey];
        [act setActPercent:[myActPercentages valueForKey:myKey]];
        [act setActSelected:[myActSelected valueForKey:myKey]];
        [act setActIcon:[myActIcons valueForKey:myKey]];
        [act setActSequence:[myActSequence valueForKey:myKey]];
        if (!activities) {
            activities = [[NSMutableArray alloc] init];
        }
        [activities insertObject:act atIndex:0];
        NSLog(@"Objects:%d",activities.count);
        NSLog(@"Activity: %@, %@, %@, %@", act.actActivity,act.actPercent, act.actSelected,act.actIcon);
    }
    // sortieren nach Sequence...
    NSSortDescriptor * sortSequence = [[NSSortDescriptor alloc] initWithKey:@"actSequence" ascending:YES];
    NSArray *sortDescriptors = @[sortSequence];
    [activities sortUsingDescriptors:sortDescriptors];
    
    // Init temp Array for fetching data from plist
    NSMutableDictionary * tmpDictionary;
    
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
    NSSortDescriptor * sortHistory = [[NSSortDescriptor alloc] initWithKey:@"histPrimaryKey" ascending:NO];
    NSArray *sortedHistory = @[sortHistory];
    [activitiesHistory sortUsingDescriptors:sortedHistory];

    
}



#pragma mark write/load Dictionary to/from file

- (void)writeDictionaryToFile:(NSMutableDictionary *)tmpDictionary toFile:(NSString *)filename {
    NSString *errorDesc=nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:filename];
    NSData *plistData = [NSPropertyListSerialization
                         dataFromPropertyList:tmpDictionary
                         format:NSPropertyListXMLFormat_v1_0
                         errorDescription:&errorDesc];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        NSLog(@"\nplist saved:%@", plistPath);
    }
    else {
        NSLog(@"Error saving plist: %@", errorDesc);
    }
}

- (NSMutableDictionary *)getDictionaryFromFile:(NSString *)plistPath {
    NSMutableDictionary *newDictionary;
    NSPropertyListFormat format;
    NSString *errorDesc  = nil;
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    newDictionary = (NSMutableDictionary *)[NSPropertyListSerialization
                                            propertyListFromData:plistXML
                                            mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                            format:&format
                                            errorDescription:&errorDesc];
    if (!newDictionary) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    } else {
        NSLog(@"\nplist loaded: %@",plistPath);
    }
    return newDictionary;
}



@end
