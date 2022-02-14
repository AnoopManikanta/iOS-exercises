//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

var itemDataSource: ItemStore!

class ViewController: UIViewController {
    var itemStore: ItemStore!
    var tableView: UITableView!
    // TODO: access modifiers for UI functions
    
    // add new item to the table
    @objc func addNewItem() {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // toggle table's editing mode
    @objc func toggleEditingMode() {
        if tableView.isEditing {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.tableEdit(), style: .plain, target: self, action: #selector(toggleEditingMode))
            tableView.setEditing(false, animated: true)
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.tableDone(), style: .done, target: self, action: #selector(toggleEditingMode))
            tableView.setEditing(true, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDataSource = itemStore
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.title()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: R.string.localizable.tableEdit(), style: .plain, target: self, action: #selector(toggleEditingMode))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.tableAdd(), style: .plain, target: self, action: #selector(addNewItem))
        tableView = createTableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
    
    private func editButton() -> UIButton {
        let editButton = UIButton()
        editButton.setTitle(R.string.localizable.tableEdit(), for: .normal)
        editButton.setTitleColor(.blue, for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        return editButton
    }

    private func addButton() -> UIButton {
        let addButton = UIButton()
        addButton.setTitle(R.string.localizable.tableAdd(), for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }

    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemCell.self, forCellReuseIdentifier: R.string.localizable.cellID())
        tableView.rowHeight = 65
        return tableView
    }
}

extension UIViewController:  UITableViewDelegate, UITableViewDataSource {
    // Move table's cells from position to the other
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemDataSource.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // Setting number of rows in the table
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemDataSource.allItems.count
    }
    
    // Setting data that each cell of the table should hold
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! ItemCell
        
        // set the text on the cell with the description of the item that is the nth index of items
        // where n = row this cell will appear on the table view
        let item = itemDataSource.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    // Delete a cell from the row
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemDataSource.allItems[indexPath.row]
            itemDataSource.removeItem(item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Display new View controller with details of the tapped cell
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let item = itemDataSource.allItems[row]
            let detailViewController = DetailViewController()
            detailViewController.item = item
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            preconditionFailure(R.string.localizable.viewError())
        }
    }
}
