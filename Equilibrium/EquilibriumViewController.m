//
//  EquilibriumViewController.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "EquilibriumViewController.h"
#import "BNPieChart.h"


@interface EquilibriumViewController ()

@end

@implementation EquilibriumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //  Sample usage:
    //   PieChart* chart = [[PieChart alloc] initWithFrame:myFrame];
    //   [chart addSlicePortion:0.35 withName:@"Yes"];
    //   [chart addSlicePortion:0.40 withName:@"No"];
    //   [chart addSlicePortion:0.25 withName:@"Maybe"];  // portions add to 1.0
    //   [mySuperview addSubview:chart];
    //
    
    CGRect myFrame = CGRectMake(10, 45, 300, 300);
    BNPieChart * chart = [[BNPieChart alloc] initWithFrame:myFrame];
    [chart addSlicePortion:0.08 withName:@"Essen"];  // portions add to 1.0
    [chart addSlicePortion:0.05 withName:@"Spazieren"];  // portions add to 1.0
    [chart addSlicePortion:0.33 withName:@"Schlafen"];
    [chart addSlicePortion:0.05 withName:@"Lesen"];  // portions add to 1.0
    [chart addSlicePortion:0.05 withName:@"Fliegen"];  // portions add to 1.0
    [chart addSlicePortion:0.25 withName:@"Arbeiten"];
    [chart addSlicePortion:0.14 withName:@"Familie"];  // portions add to 1.0
    [chart addSlicePortion:0.05 withName:@"Sport"];  // portions add to 1.0
    [self.view addSubview:chart];

    // iAd
    ADBannerView *iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0,412,0,0)];
    //iAdBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    iAdBanner.delegate = self;
    [self.view addSubview:iAdBanner];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark iAd integration

BOOL equilibriumBannerVisible = NO;


-(void) bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!equilibriumBannerVisible) {
        [UIView beginAnimations:@"bannerApear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        equilibriumBannerVisible = YES;
    }
    
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (equilibriumBannerVisible) {
        [UIView beginAnimations:@"bannerDisapear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        equilibriumBannerVisible = NO;
    }
}

-(BOOL) bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

-(void) banerViewActionDiDFinisch: (ADBannerView *)banner{
    
    NSLog(@"Bin zurück aus der Werbung");
    
}


@end
