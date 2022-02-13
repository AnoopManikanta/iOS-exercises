//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func headerView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let editBtn = UIButton()
        editBtn.setTitle("edit", for: .normal)
        editBtn.setTitleColor(.blue, for: .normal)
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        editBtn.addTarget(self, action: #selector(toggleEditingMode(_:)), for: .touchUpInside)

        let addBtn = UIButton()
        addBtn.setTitle("add", for: .normal)
        addBtn.setTitleColor(.blue, for: .normal)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.addTarget(self, action: #selector(addNewItem(_:)), for: .touchUpInside)

        headerView.addSubview(editBtn)
        headerView.addSubview(addBtn)
        NSLayoutConstraint.activate([
            editBtn.bottomAnchor.constraint(equalTo: headerView.layoutMarginsGuide.bottomAnchor),
            editBtn.leadingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.leadingAnchor),
            editBtn.widthAnchor.constraint(equalTo: headerView.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -20),
            addBtn.bottomAnchor.constraint(equalTo: headerView.layoutMarginsGuide.bottomAnchor),
            addBtn.trailingAnchor.constraint(equalTo: headerView.layoutMarginsGuide.trailingAnchor),
            addBtn.widthAnchor.constraint(equalTo: headerView.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -20)
        ])
        
        return headerView
    }
    
    @objc func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func toggleEditingMode(_ sender: UIButton) {
        if tableView.isEditing {
            sender.setTitle("Edit", for: .normal)
            tableView.setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            tableView.setEditing(true, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ItemCell
        
        // set the text on the cell with the description of the item that is the nth index of items
        // where n = row this cell will appear on the table view
        let item = itemStore.allItems[indexPath.row]
        print("ss")
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            itemStore.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    var itemStore: ItemStore!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        itemStore = ItemStore()
        
        tableView.register(ItemCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView()
        view.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        view.backgroundColor = UIColor.white
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
}
