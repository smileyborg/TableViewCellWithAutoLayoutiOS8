//
//  RJTableViewController.m
//  TableViewController
//
//  Created by Kevin Muldoon on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//

#import "RJTableViewController.h"
#import "RJModel.h"
#import "RJTableViewCell.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface RJTableViewController ()
@property (strong, nonatomic) RJModel *model;
@end

@implementation RJTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Table View Controller";
        self.model = [[RJModel alloc] init]; [self.model populateDataSource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[RJTableViewCell class] forCellReuseIdentifier:CellIdentifier];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return [self.model.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.bodyLabel.text = [dataSourceItem valueForKey:@"body"];
    
    return cell;
}


// When – tableView:heightForRowAtIndexPath: && tableView:estimatedHeightForRowAtIndexPath: are commented out
// cells will populate, but the cell heights will not be adjusted.


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    // Dequeue a cell for the particular layout required (you will likely need to substitute
    // the reuse identifier dynamically at runtime, instead of a static string as below).
    // Note that this method will init and return a new cell if there isn't one available in the reuse pool,
    // so either way after this line of code you will have a cell with the correct constraints ready to go.
    
    RJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell with content for the given indexPath, for example:
    // cell.textLabel.text = someTextForThisCell;
    // ...
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.bodyLabel.text = [dataSourceItem valueForKey:@"body"];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"My returned height = %f", height);
    */
    
//    return height;
   
    return 88.0f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return a fixed constant if possible, or do some minimal calculations if needed to be able to return an
    // estimated row height that's at least within an order of magnitude of the actual height.
    // For example:
    
    return 150.0f;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
