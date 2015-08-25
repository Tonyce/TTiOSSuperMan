//
//  Diary+CoreDataProperties.swift
//  superman
//
//  Created by D_ttang on 15/7/29.
//  Copyright © 2015年 D_ttang. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Diary {

    @NSManaged var colorEntryIndex: NSNumber?
    @NSManaged var content: String?
    @NSManaged var time: String?
    @NSManaged var baked: NSNumber?
}
