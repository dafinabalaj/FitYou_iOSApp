//
//  ViewController.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
}

