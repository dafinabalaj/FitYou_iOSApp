import UIKit
import SQLite3
import CryptoKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var databasePointer: OpaquePointer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func loginClicked(_ sender: UIButton) {
        let databaseName = "MobileAppDatabase.db"

        guard let pointer = DBHelper.getDatabasePointer(databaseName: databaseName) else {
            // Handle the case where database pointer retrieval fails
            print("Failed to get database pointer.")
            return
        }

        databasePointer = pointer

        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Please enter your username")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password")
            return
        }

        guard let db = databasePointer else {
            showAlert(message: "Database connection is not available")
            return
        }

        // Retrieve hashed password and salt from the database
        guard let (hashedPasswordFromDB, saltFromDB) = getHashedPasswordAndSalt(for: username, from: db) else {
            showAlert(message: "User does not exist")
            return
        }

        // Hash the entered password with the salt from the database
        guard let hashedEnteredPassword = hashPassword(password, salt: saltFromDB) else {
            showAlert(message: "Error hashing password")
            return
        }

        // Compare the hashed entered password with the hashed password from the database
        if hashedEnteredPassword == hashedPasswordFromDB {
            showAlert(message: "Login Successful")
        } else {
            showAlert(message: "Invalid username or password")
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   func getHashedPasswordAndSalt(for username: String, from db: OpaquePointer) -> (String, String)? {
       let query = "SELECT password, salt FROM users WHERE username = ?"
       var statement: OpaquePointer? = nil

       guard sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK else {
           print("Error preparing query statement")
           return nil
       }

       defer {
           sqlite3_finalize(statement)
       }

       guard sqlite3_bind_text(statement, 1, username, -1, nil) == SQLITE_OK else {
           print("Error binding username to query statement")
           return nil
       }

       guard sqlite3_step(statement) == SQLITE_ROW else {
           print("No user found with the given username")
           return nil
       }

       guard let passwordCString = sqlite3_column_text(statement, 0),
             let saltCString = sqlite3_column_text(statement, 1) else {
           print("Error retrieving password or salt from the database")
           return nil
       }

       let password = String(cString: passwordCString)
       let salt = String(cString: saltCString)

       return (password, salt)
   }


    // Function to hash a password with a given salt
    func hashPassword(_ password: String, salt: String) -> String? {
        let passwordWithSalt = password + salt

        if let passwordData = passwordWithSalt.data(using: .utf8) {
            let hashed = SHA256.hash(data: passwordData)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }

        return nil
    }
}





