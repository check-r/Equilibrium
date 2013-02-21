//
//  ActivitiesDetailsViewController.m
//  Equilibrium
//
//  Created by Stefan on 18.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "ActivitiesDetailsViewController.h"
#import <math.h>

@interface ActivitiesDetailsViewController ()
- (void)configureView;
@end

@implementation ActivitiesDetailsViewController

@synthesize prozentSumme;


- (NSRoundingMode)roundingMode{
    return NSRoundPlain;
}

- (short)scale{
    // The scale could return NO_SCALE for no defined scale.
    return 2;
}

- (NSDecimalNumber *)exceptionDuringOperation:(SEL)operation error:(NSCalculationError)error leftOperand:(NSDecimalNumber *)leftOperand rightOperand:(NSDecimalNumber *)rightOperand{
    // Receiver can raise, return a new value, or return nil to ignore the exception.
    return nil;
}



#pragma mark - Managing the detail item

- (void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"DetailView will disappear, Object %@", [[[self objects] objectAtIndex:self.myItemNumber] actActivity]);
    [self.objects replaceObjectAtIndex:self.myItemNumber withObject:self.detailItem];
    
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.myActivityTextField.text = [self.detailItem actActivity];
        NSNumber *tmp = [self.detailItem actSelected];
        [self.mySwitchActivitySelected setOn:tmp.boolValue animated:YES]; //.set = tmp.boolValue;
        //NSLog(@"Bool: %i", tmp.boolValue);
        self.myPercentageLabel.text = [[NSString alloc] initWithFormat:@"%@%%",[self.detailItem actPercent]];
        NSString * tmpString = self.detailItem.actIcon;
        NSString * tmpFile = [[NSBundle mainBundle] pathForResource:tmpString ofType:@"png" ];
        UIImage * pic = [[UIImage alloc] initWithContentsOfFile:tmpFile];
        self.myImage.image = pic;
        NSNumber * myPercentage = [self.detailItem actPercent];
        
        [self recalculateLabel];
        
        // slider config
        self.mySlider.minimumValue = 0;
        float myFloatPercentage = myPercentage.floatValue;
        myFloatPercentage = myFloatPercentage / 100;
        self.mySlider.value = myFloatPercentage;
        if ([[self.detailItem actSelected] boolValue]) {
            myFloatPercentage = ((100 - prozentSumme) / 100.f) + myFloatPercentage;
        } else {
            myFloatPercentage = ((100 - prozentSumme) / 100.f);
        }
        self.mySlider.maximumValue = myFloatPercentage;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self configureView];
    // iAd
    ADBannerView *iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0,366,0,0)];
    //iAdBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    iAdBanner.delegate = self;
    [self.view addSubview:iAdBanner];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}


- (IBAction)tabInvisibleButtun:(id)sender {
    
    self.detailItem.actActivity = self.myActivityTextField.text;
    [self.myActivityTextField resignFirstResponder];
    
}

- (IBAction)mySwitchActivitySelected:(id)sender {
    
    self.detailItem.actSelected = [NSNumber numberWithBool:self.mySwitchActivitySelected.isOn];
    [self configureView];
}

- (IBAction)mySliderChange:(id)sender {
    
    float newPercentage = self.mySlider.value * 100;
    NSLog(@"Slider:%f",newPercentage);
    NSNumber * setNewPercentage = [[NSNumber alloc] initWithFloat:newPercentage];
    int newIntValue = [setNewPercentage intValue];
    self.myPercentageLabel.text = [[NSString alloc] initWithFormat:@"%d%%",newIntValue];
    self.detailItem.actPercent = [NSNumber numberWithInt:newIntValue];
    
    // Berechnung des label ...
    [self recalculateLabel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // called when 'return' key pressed. return NO to ignore.
    
    self.detailItem.actActivity = self.myActivityTextField.text;
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)prozentSummeNeuBerechnen
{
    // Berechnung des label ...
    prozentSumme = 0;
    for (Activity * obj in self.objects) {
        if ([[obj actSelected] boolValue]) {
            prozentSumme = prozentSumme + [[obj actPercent] intValue];
            NSLog(@"Activity:%@ prozent Summe:%i", obj.actActivity, prozentSumme);
        }
    }
}

- (void)recalculateLabel
{
    [self prozentSummeNeuBerechnen];
    NSString * labelText = [[NSString alloc] initWithFormat:@"Zum nichts tun bleiben Dir nur noch %i%%", 100 - prozentSumme];
    self.mySecondLabel.text = labelText;
    
    
    float calc = [[self.detailItem actPercent] integerValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    calc = calc / 100.f * 24.f * 7.f / 5.f;
    NSString * strCalc1 = [formatter stringFromNumber:[NSNumber numberWithFloat:calc]];
    calc = calc / 7.f * 5.f;
    NSString * strCalc2 = [formatter stringFromNumber:[NSNumber numberWithFloat:calc]];
    calc = calc * 7.f;
    [formatter setMaximumFractionDigits:0];
    NSString * strCalc3 = [formatter stringFromNumber:[NSNumber numberWithFloat:calc]];
    calc = calc / 7.f * 30.f;
    NSString * strCalc4 = [formatter stringFromNumber:[NSNumber numberWithFloat:calc]];
    NSString * calcText = [[NSString alloc] initWithFormat:@"%@ Stunden am Tag (5-Tage Woche)\n%@ Stunden jeden Tag (7-Tage Woche)\n\n%@ Stunden in der Woche\n%@ Stunden im Monat", strCalc1, strCalc2, strCalc3, strCalc4];
    
    self.myCalcLabel.text = calcText;
    
    //    calc = 5.0f;
    //    calc = calc / 2.0f;
    //    strCalc1 = [formatter stringFromNumber:[NSNumber numberWithFloat:calc]];
    //    NSLog(@"%f, %@",calc,strCalc1);
    
}

#pragma mark iAd integration

BOOL actDetailsBannerVisible = NO;

-(void) bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!actDetailsBannerVisible) {
        [UIView beginAnimations:@"bannerApear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        actDetailsBannerVisible = YES;
    }
    
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (actDetailsBannerVisible) {
        [UIView beginAnimations:@"bannerDisapear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        actDetailsBannerVisible = NO;
    }
}

-(BOOL) bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

-(void) banerViewActionDiDFinisch: (ADBannerView *)banner{
    
    NSLog(@"Bin zurück aus der Werbung");
    
}




@end



