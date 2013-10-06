//
//  MDMasterViewController.m
//  HelloiOS
//
//  Created by Yu Hongda on 13-5-19.
//  Copyright (c) 2013年 Yu Hongda. All rights reserved.
//

#import "MDMasterViewController.h"
#import "MDDetailViewController.h"
#import "Album.h"
#import "HDSlideNavigationController.h"

@interface MDMasterViewController ()

@end

@implementation MDMasterViewController

//@synthesize nav;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"CD List", @"CD List");
    }
    return self;
}

- (void)dealloc
{}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //[self.nav.topItem setTitle:@"CD List"];
    listOfCDs  = [[NSMutableArray alloc] init];
    [listOfCDs addObject:[[Album alloc] initWithName: @"世界 - 逃跑计划" andId:1]];
    [listOfCDs addObject:[[Album alloc] initWithName: @"Let It Be - The Beatles" andId:2]];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEvent:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]] setSelected:YES];
    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]] setHighlighted:NO animated:YES];
//    [self.tableView reloadData];
}

- (void)cancelEvent:(id)sender
{
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionFlipFromRight |
     UIViewAnimationOptionLayoutSubviews |
     UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         [self.navigationController.view setFrame:CGRectMake(320.0f, 0.0f, 320.0f, 480.0f)];
                     }
                     completion:^ (BOOL finished){
                        if (self.navigationController.view.frame.size.width == 0) {
                            [self.view removeFromSuperview];
                            [self.navigationController.view removeFromSuperview];

                        }
                     }];
    
    

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return listOfCDs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    NSData *object = [listOfCDs objectAtIndex:indexPath.row];
    cell.textLabel.text = ((Album*)object).albumName;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row) {
        return YES;
    }else{
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [listOfCDs removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[MDDetailViewController alloc] initWithNibName:@"MDDetailViewController" bundle:nil];
    }
    NSDate *object = [listOfCDs objectAtIndex:indexPath.row];
    self.detailViewController.detailItem = object;
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setHighlighted:YES];
    selectedRow = indexPath.row;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    
}

@end
