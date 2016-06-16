//
//  Comment.swift
//  Timeline
//
//  Created by Karl Pfister on 6/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Comment: SyncableObject, SearchableRecord {

    convenience init(post: Post, text: String, timestap: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Comment", inManagedObjectContext: context) else {
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.text = text
        self.post = post
        self.timestamp = timestamp
        self.recordName = NSUUID().UUIDString
        //TODO: Replace with cloudkitmanaged object property name for record
    }
    
    func matchesSearchTerm(searchTerm: String) -> Bool {
        return text?.containsString(searchTerm) ?? false
    }

}
