//
//  ToDoListVC.swift
//  Todoey
//
//  Created by adol kazmy on 03/05/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {
    
    var listArray = [Item]()
    let dataFilePathe = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
                 loadItems()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
 
        let item = listArray[indexPath.row]

        cell.textLabel?.text = item.Title

        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.Done ? .checkmark : .none

     
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

//
        
        if listArray[indexPath.row].Done == false {
            listArray[indexPath.row].Done = true
            
        } else {
            listArray[indexPath.row].Done = false
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
       
    }


    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new Todoey item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
    
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
        
            let newItem = Item()
            newItem.Title = textField.text!

            self.listArray.append(newItem)
            self.saveItems()
            
            

        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(listArray)
            try data.write(to: dataFilePathe!)}
        catch {print("error while encoding\(error)")}
        tableView.reloadData()
        
    }
    
    
    func loadItems() {
        
        
        
        if let data = try? Data(contentsOf: dataFilePathe!) {
            let decoder = PropertyListDecoder()
       
        do { listArray = try decoder.decode([Item].self, from: data) }
        catch {"error while decoding \(error)"}

    }
    }
}
