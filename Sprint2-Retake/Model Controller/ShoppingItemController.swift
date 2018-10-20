//
//  ShoppingItemController.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class ShoppingItemController {
    
    var shoppingItems: [ShoppingItem] = []
    
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
        let shoppingItem = ShoppingItem(name: name, image: image, isAdded: isAdded)
        
        shoppingItems.append(shoppingItem)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    func update(shoppingItem: ShoppingItem, name: String, image: String, isAdded: Bool) {
        guard let index = shoppingItems.index(of: shoppingItem) else { return }
        
        shoppingItems[index].name = name
        shoppingItems[index].image = image
        shoppingItems[index].isAdded = isAdded
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
    
    func delete(shoppingItem: ShoppingItem) {
        guard let index = shoppingItems.index(of: shoppingItem) else { return }
        
        shoppingItems.remove(at: index)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
   
    func updateIsAdded(for shoppingItem: ShoppingItem) {
        guard let index = shoppingItems.index(of: shoppingItem) else { return }
        
        shoppingItems[index].isAdded = !shoppingItems[index].isAdded
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
    }
}
