//
//  ViewController.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-07.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Maxime is a Boss"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Maxime is The best"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Maxime Knows how to dunk"
        itemArray.append(newItem3)
        
        
        
        
         if  let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            
            itemArray = items
         }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
       
            
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    // Mark Add new Item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "New Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
       
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    


}

