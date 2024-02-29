import UIKit

class OrderTableController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var adresaField: UITextField!
    @IBOutlet weak var telefoniField: UITextField!
    
    @IBOutlet var control: UISegmentedControl!
   
    var selectedFood: String?
    
    let foodItems = ["Chicken Burrito", "Chicken Salad", "Gluten Free Toast" , "Vegan Salad" , "Oat Pancakes" , "Vegetarian Burrito" , "Rainbow Pizza" , "Gluten Free Penne" , "Pasta Salad" , "Glazed Salmon" , "Teriyaki Noodles" , "Special Lasagna"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        pickFood.dataSource = self
        pickFood.delegate = self
        
       
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
        return 1
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
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            print("Cash selected")
        }else if sender.selectedSegmentIndex == 1 {
            print("Card selected")
            
        }
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
        
        var paymentMethod: String
        
      
        if control.selectedSegmentIndex == 0 {
            paymentMethod = "Cash"
        } else {
            paymentMethod = "Card"
        }
        
        OrderRepository.insertOrder(db: pointer, username: user!.username, address: adresa, number: telefoni, food: selectedFood, paymentMethod: paymentMethod)
        showAlert(message: "Order Successful")
        
        
    
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        
            for viewController in self.navigationController!.viewControllers {
                if let menuViewController = viewController as? HomeViewController {
                    self.navigationController?.popToViewController(menuViewController, animated: true)
                    break
                }
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
