//
//  PostListTableViewController.swift
//  Timeline
//
//  Created by Karl Pfister on 6/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class PostListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var fetchedResultsController: NSFetchedResultsController?
    var searchController: UISearchController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFetchedResultsController()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard let sections = fetchedResultsController?.sections else {return 1}
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    // MARK: - Fetched Results Controller
    
    func setUpFetchedResultsController() {
        
        let request = NSFetchRequest(entityName: "Post")
        let dateSortDescription = NSSortDescriptor(key: "timestamp", ascending: false)
        
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [dateSortDescription]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch request: \(error.localizedDescription)")
        }
        
        fetchedResultsController?.delegate = self
    }
    // MARK: - Search Controller
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = true
        tableView.tableHeaderView = searchController?.searchBar
        
        definesPresentationContext = true
    }
    
    // MARK: - UISearchResultsDelegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if let resultsViewController = searchController.searchResultsController as? SearchResultsTableViewController,
            let searchTerm = searchController.searchBar.text?.lowercaseString,
            let posts = fetchedResultsController?.fetchedObjects as? [Post] {
            
            resultsViewController.resultsArray = posts.filter({$0.matchesSearchTerm(searchTerm)})
            resultsViewController.tableView.reloadData()
        }
    }

    
    
    
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as? PostTableViewCell ?? PostTableViewCell()
        
        let post = PostController.sharedInstance.posts[indexPath.row]
        cell.updateWithPost(post)
        
        return cell
     }
    
    
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toPostDetail" {
            
            if let detailViewController = segue.destinationViewController as? PostDetailTableViewController,
                let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                let post = fetchedResultsController?.objectAtIndexPath(selectedIndexPath) as? Post {
                
                detailViewController.post = post
            }
        }
        
        if segue.identifier == "toPostDetailFromSearch" {
            if let detailViewController = segue.destinationViewController as? PostDetailTableViewController,
                let sender = sender as? PostTableViewCell,
                let selectedIndexPath = (searchController?.searchResultsController as? SearchResultsTableViewController)?.tableView.indexPathForCell(sender),
                let searchTerm = searchController?.searchBar.text?.lowercaseString,
                let posts = fetchedResultsController?.fetchedObjects?.filter({ $0.matchesSearchTerm(searchTerm) }) as? [Post] {
                
                let post = posts[selectedIndexPath.row]
                
                detailViewController.post = post
            }
        }
    }
   }

extension PostListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        //Need to signal to your table view that something is going to happen.
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
                default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Delete:
            guard let indexPath = indexPath else { return }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        case .Move:
            guard let newIndexPath = newIndexPath, indexPath = indexPath else { return }
            tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        // Need to signal to your tableview that everthing is done changing.
        tableView.endUpdates()
    }
}
