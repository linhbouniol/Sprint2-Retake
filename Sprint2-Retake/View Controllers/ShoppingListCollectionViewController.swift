//
//  ShoppingListCollectionViewController.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    var shoppingItemController = ShoppingItemController()
    
    lazy var fetchedResultsController: NSFetchedResultsController<ShoppingItem> = {
        let fetchRequest: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isAdded", ascending: true),
                                        NSSortDescriptor(key: "name", ascending: true)]
        
        let moc = CoreDataStack.shared.mainContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: moc,
                                             sectionNameKeyPath: "isAdded",
                                             cacheName: nil)
       
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            NSLog("Error fetching: \(error)")
        }
        return frc
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    // three other methods are optional
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // just reload after all changes are made
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! ShoppingItemCollectionHeaderView
        
        if indexPath.section == 0 {
            headerView.headerLabel.text = "Not Added Items"
        } else {
            headerView.headerLabel.text = "Added Items"
        }
        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingItemCell", for: indexPath) as! ShoppingItemCollectionViewCell
    
        cell.shoppingItem = fetchedResultsController.object(at: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let indexPath = indexPath.item
        
        let shoppingItem = fetchedResultsController.object(at: indexPath)
        
        shoppingItemController.updateIsAdded(for: shoppingItem)
        
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ShoppingDetailViewController {
            detailVC.shoppingItemController = shoppingItemController
            detailVC.numberOfShoppingItems = shoppingItemController.shoppingList.count
        }
     }
}
