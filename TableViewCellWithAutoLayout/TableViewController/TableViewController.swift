//
//  TableViewController.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Tyler Fox
//

import UIKit

class TableViewController : UITableViewController
{
    let kCellIdentifier = "CellIdentifier"
    
    var model = Model()
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(style: UITableViewStyle)
    {
        super.init(style: style)
        
        model.populate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "iOS 8 Self Sizing Cells"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "clear")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addRow")
        
        tableView.allowsSelection = false
        
        // Select either a programatically created cell or a nib-based one.
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        // tableView.registerNib(UINib(nibName: "NibTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCellIdentifier)
        
        // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view be set to the constant UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension

        // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
        // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
        // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
        tableView.estimatedRowHeight = 44.0 // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // This function will be called when the Dynamic Type user setting changes (from the system Settings app)
    func contentSizeCategoryChanged(notification: NSNotification)
    {
        tableView.reloadData()
    }
    
    // Deletes all rows in the table view and replaces the model with a new empty one
    func clear()
    {
        let rowsToDelete: NSMutableArray = []
        for (var i = 0; i < model.dataArray.count; i++) {
            rowsToDelete.addObject(NSIndexPath(forRow: i, inSection: 0))
        }
        
        model = Model()
        
        tableView.deleteRowsAtIndexPaths(rowsToDelete, withRowAnimation: .Automatic)
    }
    
    // Adds a single row to the table view
    func addRow()
    {
        model.addSingleItem()
        
        let lastIndexPath = NSIndexPath(forRow: model.dataArray.count - 1, inSection: 0)
        tableView.insertRowsAtIndexPaths([lastIndexPath], withRowAnimation: .Automatic)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return model.dataArray.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell: TableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as TableViewCell
        
        // Configure the cell for this indexPath
        cell.updateFonts()
        let modelItem = model.dataArray[indexPath.row]
        cell.titleLabel.text = modelItem.title
        cell.bodyLabel.text = modelItem.body
        
        // Make sure the constraints have been added to this cell, since it may have just been created from scratch
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
                
        return cell
    }
    
    /*
    override func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
    // If you are just returning a constant value from this method, you should instead just set the table view's
    // estimatedRowHeight property (in viewDidLoad or similar), which is even faster as the table view won't
    // have to call this method for every row in the table view.
    //
    // Only implement this method if you have row heights that vary by extreme amounts and you notice the scroll indicator
    // "jumping" as you scroll the table view when using a constant estimatedRowHeight. If you do implement this method,
    // be sure to do as little work as possible to get a reasonably-accurate estimate.
    
    return 44.0
    }
    */
}
