//
//  ShoppingItemController.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation
import CoreData

class ShoppingItemController {
    
    init() {
        if !UserDefaults.standard.bool(forKey: "LaunchedBefore") { // if true, create items
            UserDefaults.standard.set(true, forKey: "LaunchedBefore")
            
            self.createShoppingItem(withName: "Apple", image: "apple")
            self.createShoppingItem(withName: "Grapes", image: "grapes")
            self.createShoppingItem(withName: "Milk", image: "milk")
            self.createShoppingItem(withName: "Muffin", image: "muffin")
            self.createShoppingItem(withName: "Popcorn", image: "popcorn")
            self.createShoppingItem(withName: "Soda", image: "soda")
            self.createShoppingItem(withName: "Strawberries", image: "strawberries")
        }
    }
    
    func createShoppingItem(withName name: String, image: String, isAdded: Bool = false) {
        let _ = ShoppingItem(name: name, image: image, isAdded: isAdded)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
   
    func updateIsAdded(for shoppingItem: ShoppingItem) {
        
        shoppingItem.isAdded = !shoppingItem.isAdded
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    // fetch the added items from core data
    var shoppingList: [ShoppingItem] {
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        fetchRequest.predicate = NSPredicate(format: "isAdded == true")
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching shopping list: \(error)")
            return []
        }
    }
}
