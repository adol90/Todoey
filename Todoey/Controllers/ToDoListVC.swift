//
//  ToDoListVC.swift
//  Todoey
//
//  Created by adol kazmy on 03/05/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import CoreData


class ToDoListVC: UITableViewController {
    
    var listArray = [Item]()
    
//    let dataFilePathe = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        loadItems()
              
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
 
        let item = listArray[indexPath.row]

        cell.textLabel?.text = item.title

        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none

     
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

//
//
//        if listArray[indexPath.row].done == false {
//            listArray[indexPath.row].done = true
//
//        } else {
//            listArray[indexPath.row].done = false
//        }
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        
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
        
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.listArray.append(newItem)
            self.saveItems()
            
            

        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItems() {
 
        do {try context.save()}
        catch {print("error while saving context \(error)")}
        tableView.reloadData()
        
    }
    
    
    func loadItems() {
        
        
        
        let request : NSFetchRequest = Item.fetchRequest()
     
       
        do {
            listArray = try context.fetch(request) }
        catch {"error while loading attritubtes \(error)"}

    
    }
}
