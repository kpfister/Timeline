//
//  Comment.swift
//  Timeline
//
//  Created by Karl Pfister on 6/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Comment: SyncableObject {

    convenience init(post: Post, text: String, timestap: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Comment", inManagedObjectContext: context) else {
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.text = text
        self.post = post
        self.timestamp = timestamp
        // self.recordName = self.nameForManagedObject() on the master but I don't know then this is asked for
    }

}
