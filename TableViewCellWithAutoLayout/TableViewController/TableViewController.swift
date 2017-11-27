//
//  TableViewController.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Tyler Fox
//

import UIKit

class TableViewController: UITableViewController
{
    let kCellIdentifier = "CellIdentifier"
    
    var model = Model(populated: true)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "iOS 8 Self Sizing Cells"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(TableViewController.clear))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(TableViewController.addRow))
        
        tableView.allowsSelection = false
        
        
        
        /******************************************************************
        SWITCH BETWEEN PROGRAMMATIC AND INTERFACE BUILDER LOADED CELLS
        
        Uncomment ONE of the two lines below to switch between approaches.
        Make sure that the other line commented out - don't uncomment both!
        *******************************************************************/
        tableView.register(TableViewCell.self, forCellReuseIdentifier: kCellIdentifier) // uncomment this line to load table view cells programmatically
//        tableView.registerNib(UINib(nibName: "NibTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCellIdentifier) // uncomment this line to load table view cells from IB
        
        
        
        // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view be set to the constant UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension

        // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
        // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
        // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
        tableView.estimatedRowHeight = 44.0 // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.contentSizeCategoryChanged(_:)), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    // This function will be called when the Dynamic Type user setting changes (from the system Settings app)
    func contentSizeCategoryChanged(_ notification: Notification)
    {
        tableView.reloadData()
    }
    
    // Deletes all rows in the table view and replaces the model with a new empty one
    func clear()
    {
        var rowsToDelete: [IndexPath] = []
        for i in 0..<model.dataArray.count {
            rowsToDelete.append(IndexPath(row: i, section: 0))
        }
        
        model = Model(populated: false)
        
        tableView.deleteRows(at: rowsToDelete, with: .automatic)
    }
    
    // Adds a single row to the table view
    func addRow()
    {
        model.addSingleItem()
        
        let lastIndexPath = IndexPath(row: model.dataArray.count - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // This will be the case for programmatically loaded cells (see viewDidLoad to switch approaches)
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? TableViewCell {
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
        
        // This will be the case for interface builder loaded cells (see viewDidLoad to switch approaches)
        if let cell: NibTableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? NibTableViewCell {
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
        
        assert(false, "The dequeued table view cell was of an unknown type!")
        return UITableViewCell()
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
