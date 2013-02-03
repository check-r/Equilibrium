//
//  WeatherAPITest.m
//  Equilibrium
//
//  Created by Stefan on 03.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

// For iOS
#import <GHUnitIOS/GHUnit.h>


@interface WeatherAPITest : GHAsyncTestCase { }

@property (nonatomic, strong) NSString * apiresponse;


@end

@implementation WeatherAPITest

@synthesize apiresponse;

- (void)testWeatherAPIURLConnection {
    
    // Call prepare to setup the asynchronous action.
    // This helps in cases where the action is synchronous and the
    // action occurs before the wait is actually called.
    [self prepare];
 
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://igoogle.wunderground.com/cgi-bin/findweather/getForecast?query=51.455643,7.011555&unit=SI&hl=de"]];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    // Wait until notify called for timeout (seconds); If notify is not called with kGHUnitWaitStatusSuccess then
    // we will throw an error.
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];
    GHAssertTrue([self.apiresponse rangeOfString:@"<title>Essen, Deutschland Wetter"].location != NSNotFound, @"Response string does not contain forecast information");
    //[connection release];
    connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Notify of success, specifying the method where wait is called.
    // This prevents stray notifies from affecting other tests.
    [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testWeatherAPIURLConnection)];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Notify of connection failure
    [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testWeatherAPIURLConnection)];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSString * response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    GHTestLog(@"%@", response);
    [self setApiresponse:response]; 
    
} 

@end