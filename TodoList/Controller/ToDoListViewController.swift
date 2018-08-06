//
//  ViewController.swift
//  TodoList
//
//  Created by Phi Hoang Huy on 7/27/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Deakin"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Burwood"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Victoria"
        itemArray.append(newItem3)
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
           itemArray = items
        }
    }
    //MARK : - TableView  Datasource method
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
    //MARK :- TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemArray[indexPath.row].done == false {
            itemArray[indexPath.row].done = true
        }
        else {
            itemArray[indexPath.row].done = false
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: -Add new Item Button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new thing item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happend once the user clicks the add button
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter new Item here"
            textField  = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
}


