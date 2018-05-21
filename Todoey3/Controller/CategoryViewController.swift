//
//  CategoryViewController.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-19.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category] ()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCategories()
    }
    
   



    //Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(itemArray[indexPath.row])
        
        // itemArray[indexPath.row].setValue("completed", forKey: "title") quand on click dessus cela change le nom par completed Core Update
        
        
        // context.delete(itemArray[indexPath.row])   ce code est pour delete les ItemArray
        // itemArray.remove(at: indexPath.row)          it's core delete
        
//        categories[indexPath.row].Done = !categories[indexPath.row].Done
        //mettre check mark ou pas devant les todo
        
        
        
        saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
   
    //Mark: - Data Manipulation Methods
    
    func saveCategories() {
        
        // cette funtion sert a sauvegarder les infos du ItemArray
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
            
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        // cette function sert montrer les itemArray sauvegarder
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from category \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    @IBAction func addPressedButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new Category"
        }
        
        present(alert, animated: true, completion: nil)

        
    }
     //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
   
    
    
    
    
    
    
    
    
    
}
