//
//  ShoppingDetailViewController.swift
//  Sprint2-Retake
//
//  Created by Linh Bouniol on 10/20/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ShoppingDetailViewController: UIViewController {
    
    var shoppingItemController: ShoppingItemController?
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBAction func sendOrder(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
