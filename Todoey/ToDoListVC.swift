//
//  ToDoListVC.swift
//  Todoey
//
//  Created by adol kazmy on 03/05/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var listArray = ["buy Chicken","Buy Cock","Take Trash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = listArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new Todoey item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
    
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
        
            let newListItem = textField.text!
            self.listArray.append(newListItem)
            
            print(self.listArray)
            self.tableView.reloadData()
            

        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
