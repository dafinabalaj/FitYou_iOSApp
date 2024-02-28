//
//  LoginViewController.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

 
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
          guard let username = usernameTextField.text, !username.isEmpty else {
                  showAlert(message: "Please enter your username")
                  return
              }
              
              guard let password = passwordTextField.text, !password.isEmpty else {
                  showAlert(message: "Please enter your password")
                  return
              }

              // Assuming you have access to your SQLite database object
        if LoginRepository.loginUser(db:databasePointer, username: username, enteredPassword: password) {
                  // Login successful, perform segue or any action you want
                  showAlert(message: "Login Successful")
              } else {
                  // Login failed
                  showAlert(message: "Invalid username or password")
              }
          }
    
        
          
          func showAlert(message: String) {
              let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alert, animated: true, completion: nil)
          }
}


