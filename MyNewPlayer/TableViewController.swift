//
//  TableViewController.swift
//  MyNewPlayer
//
//  Created by Gandhi Mena Salas on 04/04/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let VC = ViewController()
    var titleList: [String]!
    var coverList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleList = VC.titleList
        coverList = VC.coverList
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return titleList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = titleList[indexPath.row]
        
        let coverSong = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(coverList[indexPath.row], ofType: "jpg")!)
        let coverData = NSData(contentsOfURL: coverSong)
        cell.imageView?.image = UIImage(data: coverData!)
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nextVC: ViewController = segue.destinationViewController as! ViewController
        let indexPath = self.tableView.indexPathForSelectedRow
        nextVC.indexSong = indexPath?.row
        
        
    }


}
