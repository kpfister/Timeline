//
//  Post.swift
//  Timeline
//
//  Created by Karl Pfister on 6/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData


class Post: SyncableObject, SearchableRecord {
    
    convenience init(photoData: NSData, timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: context) else {
            
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.photoData = photoData
        self.timestamp = timestamp
        self.recordName = NSUUID().UUIDString
    }
        var photo: UIImage? {
            if let photoData = self.photoData {
                return UIImage(data: photoData)
            } else {
                return nil
            }
        }
        
        func matchesSearchTerm(searchTerm: String) -> Bool {
            return (self.comments?.array as? [Comment])?.filter({$0.matchesSearchTerm(searchTerm)}).count > 0
        }
        
        
    }

