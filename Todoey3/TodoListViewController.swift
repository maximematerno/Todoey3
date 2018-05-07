//
//  ViewController.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-07.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Maxime is a Boss", "Maxime is The best", "Maxime Knows how to dunk"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
          else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    




}

