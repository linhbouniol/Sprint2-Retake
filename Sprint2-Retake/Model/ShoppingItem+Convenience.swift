//
//  ShoppingItem+Convenience.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingItem {
    convenience init(name: String, image: String, isAdded: Bool = false, managedObjectContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: managedObjectContext)
        
        self.name = name
        self.image = image
        self.isAdded = isAdded
    }
}
