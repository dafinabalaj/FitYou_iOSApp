import UIKit

class OrderTableController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adresaField: UITextField!
    @IBOutlet weak var telefoniField: UITextField!
    var selectedFood: String?
    
    let foodItems = ["Chicken Burrito", "Chicken Salad", "Gluten Free Toast" , "Vegan Salad" , "Oat Pancakes" , "Vegetarian Burrito" , "Rainbow Pizza" , "Gluten Free Penne" , "Pasta Salad" , "Glazed Salmon" , "Teriyaki Noodles" , "Special Lasagna"]
    // Assuming UserModel is your user model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        pickFood.dataSource = self
        pickFood.delegate = self
        
        // Assuming user is properly set before viewDidLoad
        // Example: user = UserModel(id: 1, username: "John", email: "john@example.com")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.nameLabel.text = "Emri:"
            cell.valueLabel.text = user!.username
        } else {
            cell.nameLabel.text = "Email:"
            cell.valueLabel.text = user!.email
        }
        return cell
    }
    
    @IBOutlet weak var pickFood: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Assuming you only have one column in the UIPickerView
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodItems[row]
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFood = foodItems[row]
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let adresa = adresaField.text, !adresa.isEmpty else {
            showAlert(message: "Please enter your address.")
            return
        }
        guard let telefoni = telefoniField.text, !telefoni.isEmpty else {
            showAlert(message: "Please enter your phone number.")
            return
        }
        
        guard let selectedFood = selectedFood else {
            showAlert(message: "Please select a food item")
            return
        }
        
        let databaseName = "MobileAppDatabase.db"

        guard let pointer = DBHelper.getDatabasePointer(databaseName: databaseName) else {
            print("Failed to get database pointer.")
            return
        }

        OrderRepository.insertOrder(db: pointer, username: user!.username, address: adresa, number: telefoni, food: selectedFood)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
