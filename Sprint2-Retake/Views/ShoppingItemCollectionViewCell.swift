//
//  ShoppingItemCollectionViewCell.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ShoppingItemCollectionViewCell: UICollectionViewCell {
    
    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var addedNotAddedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private func updateViews() {
        guard let shoppingItem = shoppingItem, let image = shoppingItem.image else { return }
        
        nameLabel?.text = shoppingItem.name
        imageView?.image = UIImage(named: image)
        
        if shoppingItem.isAdded == true {
            addedNotAddedLabel.text = "Added"
        } else {
            addedNotAddedLabel.text = "Not Added"
        }
    }
}
