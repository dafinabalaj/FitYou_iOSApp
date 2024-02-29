//
//  CreateAccountViewController.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import UIKit


class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    var databasePointer: OpaquePointer?

 override func viewDidLoad() {
     super.viewDidLoad()

     
 }


    @IBAction func signupClicked(_ sender: UIButton) {
        let databaseName = "MobileAppDatabase.db"

        guard let pointer = DBHelper.getDatabasePointer(databaseName: databaseName) else {
            
            print("Failed to get database pointer.")
            return
        }

        databasePointer = pointer

        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Please enter a username.")
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter an email.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter a password.")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please confirm your password.")
            return
        }
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        
        if SignupRepository.isUsernameExists(db: databasePointer, username: username) {
            showAlert(message: "Username already exists. Please choose another one.")
            return
        }

      
        if SignupRepository.isEmailExists(db: databasePointer, email: email) {
            showAlert(message: "Email already exists. Please use another one.")
            return
        }


        SignupRepository.insertUser(db: databasePointer, username: username, password: password, email: email)
        self.performSegue(withIdentifier: "goToLogin", sender: self)
        print("User inserted successfully!")
     

        showAlert(message: "Account created successfully.")
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

