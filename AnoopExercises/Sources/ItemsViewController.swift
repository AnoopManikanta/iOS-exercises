////
////  ItemsViewController.swift
////  AnoopExercises
////
////  Created by Anoop Subramani on 11/02/22.
////
//
//import UIKit
//
//class ItemsViewController: UITableViewController {
//    
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(itemStore.allItems.count)
//        return itemStore.allItems.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Creating an instance of UITableViewCell for default appearance
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
//        
//        // set the text on the cell with the description of the item that is the nth index of items
//        // where n = row this cell will appear on the table view
//        let item = itemStore.allItems[indexPath.row]
//        print("ss")
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//        
//        return cell
//    }
//}
