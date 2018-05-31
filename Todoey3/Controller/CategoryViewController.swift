//
//  CategoryViewController.swift
//  Todoey3
//
//  Created by Maxime Vacher-materno on 18-05-19.
//  Copyright © 2018 Maxime Vacher-materno. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCategories()
    }
    
   



    //Mark: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        
        return cell
    
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        // print(itemArray[indexPath.row])
//
//        // itemArray[indexPath.row].setValue("completed", forKey: "title") quand on click dessus cela change le nom par completed Core Update
//
//
//        // context.delete(itemArray[indexPath.row])   ce code est pour delete les ItemArray
//        // itemArray.remove(at: indexPath.row)          it's core delete
//
////        categories[indexPath.row].Done = !categories[indexPath.row].Done
//        //mettre check mark ou pas devant les todo
//
//
//
////        saveCategory()
//
////        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
    
   
    //Mark: - Data Manipulation Methods
    
    func save(category: Category) {
        
        // cette funtion sert a sauvegarder les infos du ItemArray
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
            
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        // cette function sert montrer les itemArray sauvegarder
       
        categories = realm.objects(Category.self)
        
        
        tableView.reloadData()
    }
    
    
    
    @IBAction func addPressedButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new Category"
        }
        
        present(alert, animated: true, completion: nil)

        
    }
     //Mark: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
   
    
    
    
    
    
    
    
    
    
}
