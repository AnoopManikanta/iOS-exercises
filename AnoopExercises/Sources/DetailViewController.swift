//
//  DetailViewController.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 13/02/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var date: UILabel!
    var item: Item!
    // Format Item Value
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
    // Format Item's Create Date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        date.text = dateFormatter.string(from: item.dateCreated)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        let name = detailednameLabel()
        let value = detailedValuelabel()
        let serial = detailiedSerialLabel()
        let verticalStack = verticalDetailsStack()
        let nameHorizontalStack = horizontalDetailsStack()
        let valueHorizontalStack = horizontalDetailsStack()
        let serialHorizontalStack = horizontalDetailsStack()
        
        nameField = TextField()
        valueField = TextField()
        serialField = TextField()
        date = detailedDatelabel()
        
        nameHorizontalStack.addArrangedSubview(name)
        nameHorizontalStack.addArrangedSubview(nameField)
        valueHorizontalStack.addArrangedSubview(value)
        valueHorizontalStack.addArrangedSubview(valueField)
        serialHorizontalStack.addArrangedSubview(serial)
        serialHorizontalStack.addArrangedSubview(serialField)
        verticalStack.addArrangedSubview(nameHorizontalStack)
        verticalStack.addArrangedSubview(serialHorizontalStack)
        verticalStack.addArrangedSubview(valueHorizontalStack)
        verticalStack.addArrangedSubview(date)
        
        view.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            verticalStack.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            serialField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            valueField.leadingAnchor.constraint(equalTo: serialField.leadingAnchor)
        ])
        name.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameField.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
    }
}

func verticalDetailsStack() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .fill
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}

func horizontalDetailsStack() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.alignment = .fill
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}

func detailednameLabel() -> UILabel {
    let name = UILabel()
    name.text = "Name"
    name.translatesAutoresizingMaskIntoConstraints = false
    name.textColor = .black
    return name
}

func detailiedSerialLabel() -> UILabel {
    let serial = UILabel()
    serial.text = "Serial"
    serial.translatesAutoresizingMaskIntoConstraints = false
    serial.textColor = .black
    return serial
}

func detailedValuelabel() -> UILabel {
    let value = UILabel()
    value.text = "Value"
    value.translatesAutoresizingMaskIntoConstraints = false
    value.textColor = .black
    return value
}

func detailedDatelabel() -> UILabel {
    let date = UILabel()
    date.text = "Date"
    date.translatesAutoresizingMaskIntoConstraints = false
    date.textColor = .black
    date.textAlignment = .center
    return date
}

func TextField() -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.layer.borderWidth = 1.0
    return textField
}
