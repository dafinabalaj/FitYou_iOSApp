import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var databasePointer: OpaquePointer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize your databasePointer here
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        let databaseName = "MobileAppDatabase.db"

        guard let pointer = DBHelper.getDatabasePointer(databaseName: databaseName) else {
            print("Failed to get database pointer.")
            return
        }

        databasePointer = pointer

        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Please enter your username.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }

        if LoginRepository.loginUser(db: databasePointer, username: username, enteredPassword: password) {
            self.performSegue(withIdentifier: "mainSegue", sender: self)
            showAlert(message: "Login successful!")
            // Navigate to the next view controller upon successful login
        } else {
            showAlert(message: "Invalid username or password.")
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}




