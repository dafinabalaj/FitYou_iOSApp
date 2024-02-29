//
//  HomeViewController.swift
//  MobileAppTest
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var FitYou: UINavigationBar!
    @IBOutlet weak var lbl1: UILabel!
    

    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var btn6: UIButton!
    
    @IBOutlet weak var btn7: UIButton!
    
    @IBOutlet weak var btn8: UIButton!
    
    @IBOutlet weak var btn9: UIButton!
    
    @IBOutlet weak var btn10: UIButton!
    
    @IBOutlet weak var btn11: UIButton!
    
    @IBOutlet weak var btn12: UIButton!
    
 

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(user!.username)
 
    }
    

    @IBAction func shopAction(_ sender: Any) {
        self.performSegue(withIdentifier: "tableSegue", sender: self)

    }
  

}
