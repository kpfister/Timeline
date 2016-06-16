//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Karl Pfister on 6/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class PostDetailTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var fetchedResultsController: NSFetchedResultsController?
    
    var post: Post?
    
    //MARK: - Outlets
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        setUpFetchedResultsController()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateWithPost(post: Post) {
        imageView.image = post.photo
        tableView.reloadData()
        
    }
    
    func setUpFetchedResultsController() {
        guard let post = post else { fatalError("Unable to use Post to set up fetched results controller.") }
        let request = NSFetchRequest(entityName: "Comment")
        let predicate = NSPredicate(format: "post == %@", argumentArray: [post])
        let dateSortDescription = NSSortDescriptor(key: "timestamp", ascending: true)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = [dateSortDescription]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request: \(error.localizedDescription)")
        }
        fetchedResultsController?.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController?.sections else {return 1}
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        
        if let comment = fetchedResultsController?.objectAtIndexPath(indexPath) as? Comment {
            
            cell.textLabel?.text = comment.text
//            cell.detailTextLabel?.text = comment.cloudKitRecordID?.recordName
        }
        
        return cell
    }
    

    /*
     if let playlist = playlist,
     song = playlist.songs.objectAtIndex(indexPath.row) as? Song {
     cell.textLabel?.text = song.name
     cell.detailTextLabel?.text = song.artist*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Actions
    
    @IBAction func followPostsButtonTapped(sender: AnyObject) {
        
    }
    
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func commentButtonTapped(sender: AnyObject) {
        presentCommentAlert()
        
    }
    
    func presentCommentAlert() {
        let alertController = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
        }
        let addCommentAction = UIAlertAction(title: "Add Comment", style: .Default) { (action) in
            guard let commentText = alertController.textFields?.first?.text,
                let post = self.post else {return}
            PostController.sharedInstance.addCommentToPost(commentText, post: post)
        }
        alertController.addAction(addCommentAction)
        
        let cancelACtion = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelACtion)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}



























