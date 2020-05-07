//
//  CategoryVc.swift
//  Todoey
//
//  Created by adol kazmy on 07/05/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import CoreData

class CategoryVc: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadItems()
    }

    // MARK: - Table view data source
    
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
        let category = categoryArray[indexPath.row]

        cell.textLabel?.text = category.name

           return cell
       }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    // MARK: - Data Manipulation
    
       func saveItems() {
    
           do {try context.save()}
           catch {print("error while saving context \(error)")}
           tableView.reloadData()
           
       }
       
       
       
       func loadItems() {
           
        let request : NSFetchRequest = Category.fetchRequest()
           do { categoryArray = try context.fetch(request)}
           catch {print("error while loading categories\(error)")}
        
           tableView.reloadData()
       }
    
    // MARK: - Add Category
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
            
            let alert = UIAlertController(title: "add new Category", message: "", preferredStyle: .alert)
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new category"
                textField = alertTextField
            }
            
        
            
            let action = UIAlertAction(title: "add category", style: .default) { (action) in
            
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categoryArray.append(newCategory)
                self.saveItems()
                
                

            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row] }
    }
    
}
