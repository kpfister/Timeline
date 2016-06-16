//
//  SearchableRecord.swift
//  Timeline
//
//  Created by Karl Pfister on 6/16/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

@ objc protocol SearchableRecord: class {
    
    func matchesSearchTerm(searchTerm: String) -> Bool
}