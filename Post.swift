//
//  Post.swift
//  Timeline
//
//  Created by Karl Pfister on 6/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData


class Post: SyncableObject {

    convenience init(photoData: NSData, timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Post", inManagedObjectContext: context) else {
            
            fatalError()
        }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.photoData = photoData
        self.timestamp = timestamp
        // self.recordName = self.nameForManagedObject() on the master but I don't know then this is asked for
    }
    
    var photo: UIImage? {
        if let photoData = self.photoData {
            return UIImage(data: photoData)
        } else {
            return nil
        }
    }
}
protocol SearchableRecord() {
    
}