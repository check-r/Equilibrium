//
//  ActivitiesViewController.m
//  Equilibrium
//
//  Created by Stefan on 18.02.13.
//  Copyright (c) 2013 Stefan Schröer. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivitiesDetailsViewController.h"

@interface ActivitiesViewController ()

@end

@implementation ActivitiesViewController

@synthesize act;



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ActivitiesDetailsViewController * dvc = [segue destinationViewController];
    NSIndexPath * path = [self.tableView indexPathForSelectedRow];
    Activity * object = [act.activities objectAtIndex:[path row]];
    dvc.detailItem = object;
    dvc.myItemNumber = path.row;
    dvc.objects = self.act.activities;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
     }
    return self;
}

- (void)startLoadingPlistData:(Activity *)activityObject
{
    [activityObject loadPlistData];
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

    self.act = [Activity sharedInstance];
    
    // refactor: auslagern zum testen
    [self startLoadingPlistData:self.act];
    
    
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
    return [act.activities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivitiesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // set Label Text
    NSString * object = [[act.activities objectAtIndex:[indexPath row]] actActivity];
    cell.textLabel.text = [object description];
    
    // set Details
    object = [[NSString alloc] initWithFormat:@"%@%%",[[act.activities objectAtIndex:[indexPath row]] actPercent]];
    cell.detailTextLabel.text = [object description];
    
    // Retrieve an set Image from NSBundle mainBundle
    object = [[act.activities objectAtIndex:[indexPath row]] actIcon];
    NSString *myImageFile = [[NSBundle mainBundle] pathForResource:object ofType:@"png"];
    UIImage *myImage = [[UIImage alloc] initWithContentsOfFile:myImageFile];
    [[cell imageView]setImage:myImage];
    
    // Set selected or not  BOOL or integer
    BOOL yep = [[[act.activities objectAtIndex:[indexPath row]] actSelected] boolValue];
    //NSLog(@"->%@ ", [selectedActivities objectForKey:myString]);
    if (yep) {
        //NSLog(@"yep");
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        //NSLog(@"no yep");
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
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
        [act.activities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Activity * tmp = [[Activity alloc] init];
    tmp = [act.activities objectAtIndex:fromIndexPath.row];
    [act.activities removeObjectAtIndex:fromIndexPath.row];
    [act.activities insertObject:tmp atIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)insertNewObject:(id)sender
{
    if (!act.activities) {
        act.activities = [[NSMutableArray alloc] init];
    }
    Activity * newAct = [[Activity alloc]init];
    newAct.actActivity = @"neue Aktivität";
    newAct.actIcon = @"Icon";
    newAct.actSelected = [[NSNumber alloc] initWithInt:1];
    newAct.actPercent = [[NSNumber alloc]initWithInt:10];
    [act.activities insertObject:newAct atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


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

BOOL actBannerVisible = NO;

-(void) bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!actBannerVisible) {
        [UIView beginAnimations:@"bannerApear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        actBannerVisible = YES;
    }
    
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    if (actBannerVisible) {
        [UIView beginAnimations:@"bannerDisapear" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        actBannerVisible = NO;
    }
}

-(BOOL) bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    return YES;
}

-(void) banerViewActionDiDFinisch: (ADBannerView *)banner{
    
    NSLog(@"Bin zurück aus der Werbung");
    
}


@end
