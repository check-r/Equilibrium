//
//  ActivitiesDetailsViewController.h
//  Equilibrium
//
//  Created by Stefan on 18.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import <iAd/iAd.h>


@interface ActivitiesDetailsViewController : UIViewController <UITextFieldDelegate, ADBannerViewDelegate, NSDecimalNumberBehaviors>


@property int myItemNumber;
@property int prozentSumme;
@property (strong, nonatomic) Activity * detailItem;
@property (strong, nonatomic) NSMutableArray * objects;
@property (weak, nonatomic) IBOutlet UILabel *myCalcLabel;
@property (weak, nonatomic) IBOutlet UILabel *mySecondLabel;


@property (weak, nonatomic) IBOutlet UITextField *myActivityTextField;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitchActivitySelected;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *myPercentageLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;



- (IBAction)tabInvisibleButtun:(id)sender;

- (IBAction)mySwitchActivitySelected:(id)sender;

- (IBAction)mySliderChange:(id)sender;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
// called when 'return' key pressed. return NO to ignore.



@end
