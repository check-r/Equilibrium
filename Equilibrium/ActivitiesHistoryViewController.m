//
//  ActivitiesHistoryViewController.m
//  Equilibrium
//
//  Created by Stefan on 22.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "ActivitiesHistoryViewController.h"

@interface ActivitiesHistoryViewController ()

@end

@implementation ActivitiesHistoryViewController

@synthesize hist;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // custom configuration
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.hist = [ActivityHistory sharedInstance];

    // iAd
    ADBannerView *iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0,367,0,0)];
    //iAdBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    iAdBanner.delegate = self;
    [self.view addSubview:iAdBanner];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return hist.activitiesHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivitiesHistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    /*
    // init objects
    int key = [indexPath row];
    NSString * keyString = [NSString stringWithFormat:@"%i", key];
    NSArray * objects = [myAct.activitiesHistory objectForKey:keyString];
    // set Label Text
    if (! isnull(objects)) then {
        cell.textLabel.text = [objects valueForKey:@"activity"];
        
        // set Details
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EE. dd.MM.yy 'um' HH:mm"];
        NSDate * startDate = [objects valueForKey:@"start"];
        NSDate * endDate = [objects valueForKey:@"ende"];
        
        NSTimeInterval interval = [endDate timeIntervalSinceDate:startDate];
        int seconds = (int) interval % 60;
        int minutes = ((int) (interval - seconds) / 60) % 60;
        int hours = (int) (interval   / 3600);
        NSString * duration = [NSString stringWithFormat:@"%02d:%02d:%02d", hours,
                               minutes, seconds];
        NSString * detail = [NSString stringWithFormat:@"%@ - Dauer: %@", [dateFormatter stringFromDate:startDate], duration];
        
        cell.detailTextLabel.text = detail;
        
        // Set selected or not  BOOL or integer
        BOOL yep = [[objects valueForKey:@"selected"] boolValue];
        if (yep) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
    }*/
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [hist.activitiesHistory removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark iAd integration

BOOL actHistoryBannerVisible = NO;

-(void) bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!actHistoryBannerVisible) {
        [UIView beginAnimations:@"bannerApear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        actHistoryBannerVisible = YES;
    }
    
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (actHistoryBannerVisible) {
        [UIView beginAnimations:@"bannerDisapear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        actHistoryBannerVisible = NO;
    }
}

-(BOOL) bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

-(void) banerViewActionDiDFinisch: (ADBannerView *)banner{
    
    NSLog(@"Bin zurück aus der Werbung");
    
}

@end
