//
//  ShoppingDetailViewController.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ShoppingDetailViewController: UIViewController {
    
    var shoppingItemController: ShoppingItemController? {
        didSet {
            updateViews()
        }
    }
    
    var numberOfShoppingItems: Int = 0
    
    let localNotificationHelper = LocalNotificationHelper()
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func sendOrder(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 0, let address = addressTextField.text, address.count > 0 else { return }
        
        // Notification request
        localNotificationHelper.getAuthorizationStatus { (authorizationStatus) in
            if authorizationStatus == .authorized {
                self.localNotificationHelper.sendOrderNotification(name: name, address: address)
                
                self.navigationController?.popViewController(animated: true)
            } else {
                self.localNotificationHelper.requestAuthorization { (success) in
                    if success {
                        self.localNotificationHelper.sendOrderNotification(name: name, address: address)
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    private func updateViews() {
        guard isViewLoaded else { return }
        
        if numberOfShoppingItems == 1 {
            textLabel?.text = "You currently have \(numberOfShoppingItems) item in your shopping list."
        } else {
            textLabel?.text = "You currently have \(numberOfShoppingItems) items in your shopping list."
        }
    }
}
