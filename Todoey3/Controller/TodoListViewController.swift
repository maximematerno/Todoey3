//
//  ViewController.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-07.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
      loadItems()
        
        
        
        
        
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
        
       // itemArray[indexPath.row].setValue("completed", forKey: "title") quand on click dessus cela change le nom par completed Core Update
        
       
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//        ce code est pour delete les ItemArray
//         it's core delete
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //mettre check mark ou pas devant les todo
        
        
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
    // Mark Add new Item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "New Item", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
       
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        // cette funtion sert a sauvegarder les infos du ItemArray
        
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems (with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        // cette function sert montrer les itemArray sauvegarder
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = predicate
        
        do{
           itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    


}

extension TodoListViewController: UISearchBarDelegate {
    
//    code for the searchBar button
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
 
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }

    
}
