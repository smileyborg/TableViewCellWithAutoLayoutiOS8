//
//  RJTableViewController.m
//  TableViewController
//
//  Created by Kevin Muldoon & Tyler Fox on 10/5/13.
//  Copyright (c) 2013 RobotJackalope. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RJTableViewController.h"
#import "RJModel.h"
#import "RJTableViewCell.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface RJTableViewController ()

@property (strong, nonatomic) RJModel *model;

// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

// For iOS 7.0.x compatibility ONLY (this bug is fixed in iOS 7.1):
// This property is used to work around the constraint exception that is thrown if the
// estimated row height for an inserted row is greater than the actual height for that row.
// See: https://github.com/caoimghgin/TableViewCellWithAutoLayout/issues/6
@property (assign, nonatomic) BOOL isInsertingRow;

@end

@implementation RJTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.model = [[RJModel alloc] init];
        [self.model populateDataSource];
        self.offscreenCells = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Auto Layout Table View";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clear:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRow:)];
    
    [self.tableView registerClass:[RJTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    self.tableView.allowsSelection = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)clear:(id)sender
{
    NSMutableArray *rowsToDelete = [NSMutableArray new];
    for (NSUInteger i = 0; i < [self.model.dataSource count]; i++) {
        [rowsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    self.model = [[RJModel alloc] init];
    
    [self.tableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView reloadData];
}

- (void)addRow:(id)sender
{
    [self.model addSingleItemToDataSource];
    
    self.isInsertingRow = YES;
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[self.model.dataSource count] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    self.isInsertingRow = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell for this indexPath
    [cell updateFonts];
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.bodyLabel.text = [dataSourceItem valueForKey:@"body"];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This project has only one cell identifier, but if you are have more than one, this is the time
    // to figure out which reuse identifier should be used for the cell at this index path.
    NSString *reuseIdentifier = CellIdentifier;
    
    // Use the dictionary of offscreen cells to get a cell for the reuse identifier, creating a cell and storing
    // it in the dictionary if one hasn't already been added for the reuse identifier.
    // WARNING: Don't call the table view's dequeueReusableCellWithIdentifier: method here because this will result
    // in a memory leak as the cell is created but never returned from the tableView:cellForRowAtIndexPath: method!
    RJTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [[RJTableViewCell alloc] init];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    // Configure the cell for this indexPath
    [cell updateFonts];
    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.bodyLabel.text = [dataSourceItem valueForKey:@"body"];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}

/*
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If you are just returning a constant value from this method, you should instead just set the table view's
    // estimatedRowHeight property (in viewDidLoad or similar), which is even faster as the table view won't
    // have to call this method for every row in the table view.
    //
    // Only implement this method if you have row heights that vary by extreme amounts and you notice the scroll indicator
    // "jumping" as you scroll the table view when using a constant estimatedRowHeight. If you do implement this method,
    // be sure to do as little work as possible to get a reasonably-accurate estimate.
 
    // NOTE for iOS 7.0.x ONLY, this bug has been fixed by Apple as of iOS 7.1:
    // A constraint exception will be thrown if the estimated row height for an inserted row is greater
    // than the actual height for that row. In order to work around this, we need to return the actual
    // height for the the row when inserting into the table view - uncomment the below 3 lines of code.
    // See: https://github.com/caoimghgin/TableViewCellWithAutoLayout/issues/6
    //    if (self.isInsertingRow) {
    //        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    //    }
    
    return UITableViewAutomaticDimension;
}
*/

@end
