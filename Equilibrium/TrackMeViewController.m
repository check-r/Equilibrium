//
//  TrackMeViewController.m
//  Equilibrium
//
//  Created by Stefan on 02.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "TrackMeViewController.h"

@interface TrackMeViewController ()

@end

@implementation TrackMeViewController

@synthesize myLocation, mapView;
@synthesize objects, activityTimer,primaryKey,myTestDictionary,currAct;



#pragma mark - View Lifecycle

- (void)beginnLocationUpdates:(Location *)location
{
    [location startLocationUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.myLocation = [[Location alloc]init];
    
    // refactor: auslagern zum testen
    [self beginnLocationUpdates:self.myLocation];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationChange:) name:@"LocationChange" object:nil];
    UITapGestureRecognizer * mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMapTap)];
    [self.mapView addGestureRecognizer:mapTap];
    
    self.mapView.showsUserLocation = YES;  // set in nib also possible, or must be used with niceMocks when set in viewDidLoad
    
    // iAd
    ADBannerView *iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0,412,0,0)];
    //iAdBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    iAdBanner.delegate = self;
    [self.view addSubview:iAdBanner];

    // TrackMe init
    self.objects = [[Activity sharedInstance] activities];
    if (!currAct) {
        self.currAct = [[CurrentActivity alloc] init];
    }
    [currAct setActivity:[[objects objectAtIndex:0] actActivity]];
    [currAct setStart:nil];
    [currAct setEnde:nil];
    [currAct setSelected:[NSNumber numberWithInt:1]];
    [self.myLabel setText:currAct.activity];
    NSString * file = [[NSBundle mainBundle] pathForResource:[[objects objectAtIndex:0] actIcon] ofType:@"png"];
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:file];
    [self.myImageView setImage:image];
    [self.mySwitch setOn:NO];
    self.myTextField.text = nil;
    NSLog(@"bin geladen");
}


-(void) viewDidUnload {
    
    [self setMapView:nil];
    [self setSpeedLabel:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    self.myLocation = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification Handler


-(void)handleLocationChange:(NSNotification *)notification {
    
    Location * location = [notification object];
    NSString * speed = [location mySpeedText];
    [self.speedLabel setText:speed];
    
}

#pragma mark - Tap Handler

-(void)handleMapTap {
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}

#pragma mark iAd integration

BOOL trackMeBannerVisible = NO;


-(void) bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!trackMeBannerVisible) {
        [UIView beginAnimations:@"bannerApear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        trackMeBannerVisible = YES;
    }
    
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (trackMeBannerVisible) {
        [UIView beginAnimations:@"bannerDisapear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        trackMeBannerVisible = NO;
    }
}

-(BOOL) bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

-(void) banerViewActionDiDFinisch: (ADBannerView *)banner{
    
    NSLog(@"Bin zurück aus der Werbung");
    
}

#pragma mark User interaction

- (IBAction)switched:(id)sender{
    
    // Bsp. "yyyy.MM.dd G 'at' HH:mm:ss zzz"
    //[myDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    //[myDateFormatter setDateStyle:NSDateFormatterLongStyle];
    //[myDateFormatter setShortStandaloneWeekdaySymbols:[[NSArray alloc] initWithObjects:@"Mo.",@"Di."@"Mi."@"Do."@"Fr."@"Sa."@"So.", nil]];
    
    NSDateFormatter * myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"E dd.MM.yy 'um' HH:mm:ss"];
    if (self.mySwitch.isOn) {
        currAct.start = [NSDate date];
        currAct.ende = nil;
        activityTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [self.activityTimer fire];
        [self.myPickerView setHidden:YES];
        
    } else {
        currAct.ende= [NSDate date];
        [self.activityTimer invalidate];
        
        NSDictionary * tmp = [[NSDictionary alloc] initWithObjectsAndKeys:currAct.activity, @"activity", currAct.start, @"start", currAct.ende, @"ende", currAct.selected, @"selected",nil];
        [myTestDictionary setValue:tmp forKey:[primaryKey stringValue]];
        int calc = primaryKey.intValue +1;
        primaryKey = [NSNumber numberWithInt:calc];
        [self.myPickerView setHidden:NO];
        
    }
    NSString * text = [[NSString alloc] initWithFormat:@"Startzeit: %@\n\n\nEndzeit: %@",[myDateFormatter stringFromDate:currAct.start],[myDateFormatter stringFromDate:currAct.ende]];
    [self.myTextField setText:text];
}

#pragma mark Picker View


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.objects.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString * tmp = [[NSString alloc] initWithString:[[objects objectAtIndex:row] actActivity]];
    NSString * aString = [[NSString alloc] initWithString:tmp];
    return aString;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    // save current activity
    //    if (self.mySwitch.isOn) {
    //        currAct.ende= [NSDate date];
    //        [self.activityTimer invalidate];
    //
    //        NSDictionary * tmp = [[NSDictionary alloc] initWithObjectsAndKeys:currAct.activity, @"activity", currAct.start, @"start", currAct.ende, @"ende", currAct.selected, @"selected",nil];
    //        [myTestDictionary setValue:tmp forKey:[primaryKey stringValue]];
    //        int calc = primaryKey.intValue +1;
    //        primaryKey = [NSNumber numberWithInt:calc];
    //    }
    //
    // setup new activity
    currAct.activity = [[objects objectAtIndex:row] actActivity];
    [self.myLabel setText:currAct.activity];
    NSString * file = [[NSBundle mainBundle] pathForResource:[[objects objectAtIndex:row] actIcon] ofType:@"png"];
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:file];
    [self.myImageView setImage:image];
    [self.mySwitch setOn:NO];
    
    //    NSDateFormatter * myDateFormatter = [[NSDateFormatter alloc] init];
    //    [myDateFormatter setDateFormat:@"E dd.MM.yy 'um' HH:mm:ss"];
    currAct.start = nil;
    currAct.ende = nil;
    //    activityTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    //    [self.activityTimer fire];
    //    NSString * text = [[NSString alloc] initWithFormat:@"Startzeit: %@\n\n\nEndzeit: %@",[myDateFormatter stringFromDate:currAct.start],[myDateFormatter stringFromDate:currAct.ende]];
    [self.myTextField setText:nil];
    self.myTimerLabel.text = @"00:00:00";
}

# pragma mark Timer


-(void) timerTick:(NSTimer *)timer {
    
    NSTimeInterval interval = -[currAct.start timeIntervalSinceNow];
    int seconds = (int) interval % 60;
    //int minutes = (int) interval / 60;
    int minutes = ((int) (interval - seconds) / 60) % 60;
    //int hours = ((int) interval - seconds - (60 * minutes)) % 3600;
    int hours = (int) (interval   / 3600);
    [self.myTimerLabel setText:[NSString stringWithFormat:@"%02d:%02d:%02d", hours,
                                minutes, seconds]];
    // Bsp. aus avPlayer
    //currentTime.text = [NSString stringWithFormat:@"%d:%02d", (int)p.currentTime / 60, (int)p.currentTime % 60, nil];
	
    NSLog(@"intervall:%f\nhours:%i\nminutes:%i\nseconds:%i",interval, hours, minutes, seconds);
    
}





@end
