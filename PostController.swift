//
//  PostController.swift
//  Timeline
//
//  Created by Karl Pfister on 6/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//


import UIKit
import CoreData

class PostController {
    
    var posts: [Post] {
        
        let fetchRequest = NSFetchRequest(entityName:"Post")
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let results = (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(fetchRequest)) as? [Post] ?? []
        
        return results
    }
    static let sharedInstance = PostController()
    // MARK: - CRUD
    
    func saveContext() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch let error as NSError{
            print(error.localizedDescription)
            print("There was an error saving the context")
        }
        //        _ = try? moc.save()
        
    }
    
    func createPost(image: UIImage, caption: String) {
        guard let photoData = UIImageJPEGRepresentation(image, 0.8) else {
            return
        }
        let post = Post(photoData: photoData)
        addCommentToPost(caption, post: post)
        saveContext()
    }
    
    func addCommentToPost(text: String, post: Post) {
        let comment = Comment(post: post, text: text)
        saveContext()
    }
    //MARK: TODO - Make my ish non-optional once i add the syncable object
    
}