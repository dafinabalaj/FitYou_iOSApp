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
    
    //buttons
    
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
        //food1.image = UIImage(named:"food1")

        // Do any additional setup after loading the view.
        //button design

         btn1.layer.cornerRadius = 10
         btn1.layer.masksToBounds = true

         btn2.layer.cornerRadius = 10
         btn2.layer.masksToBounds = true

        btn3.layer.cornerRadius = 10
        btn3.layer.masksToBounds = true
        
        btn4.layer.cornerRadius = 10
        btn4.layer.masksToBounds = true
        
        btn5.layer.cornerRadius = 10
        btn5.layer.masksToBounds = true
        
        btn6.layer.cornerRadius = 10
        btn6.layer.masksToBounds = true
        
        btn7.layer.cornerRadius = 10
        btn7.layer.masksToBounds = true
        
        btn8.layer.cornerRadius = 10
        btn8.layer.masksToBounds = true
        
        btn9.layer.cornerRadius = 10
        btn9.layer.masksToBounds = true
        
        btn10.layer.cornerRadius = 10
        btn10.layer.masksToBounds = true
        
        btn11.layer.cornerRadius = 10
        btn11.layer.masksToBounds = true
        
        btn12.layer.cornerRadius = 10
        btn12.layer.masksToBounds = true
        
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
