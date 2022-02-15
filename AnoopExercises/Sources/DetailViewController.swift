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
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
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
    
    // dismiss keyboard on view tap
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ _ in
            print("Present Camera")
        }
        alertController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ _ in
            print("Present Photo Library")
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ _ in
            print("Clicked Cancel")
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // load data before appearing on the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        date.text = dateFormatter.string(from: item.dateCreated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        let toolBar = UIToolbar()
        var toolBarItems = [UIBarButtonItem] ()
        toolBarItems.append(
            UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(choosePhotoSource))
        )
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.setItems(toolBarItems, animated: true)
//        toolBar.tintColor = .blue
        
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
        view.addGestureRecognizer(tapGesture)
        view.addSubview(toolBar)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            verticalStack.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            serialField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            valueField.leadingAnchor.constraint(equalTo: serialField.leadingAnchor),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 44),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        name.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameField.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        
        nameField.delegate = self
        valueField.delegate = self
        serialField.delegate = self
    }
    
    private func verticalDetailsStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func horizontalDetailsStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }

    private func detailednameLabel() -> UILabel {
        let name = UILabel()
        name.text = R.string.localizable.nameLabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        return name
    }

    private func detailiedSerialLabel() -> UILabel {
        let serial = UILabel()
        serial.text = R.string.localizable.serialLabel()
        serial.translatesAutoresizingMaskIntoConstraints = false
        serial.textColor = .black
        return serial
    }

    private func detailedValuelabel() -> UILabel {
        let value = UILabel()
        value.text = R.string.localizable.valueLabel()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.textColor = .black
        return value
    }

    private func detailedDatelabel() -> UILabel {
        let date = UILabel()
        date.text = R.string.localizable.dateLabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textColor = .black
        date.textAlignment = .center
        return date
    }

    private func TextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.layer.borderWidth = 1.0
        return textField
    }
}

extension UIViewController: UITextFieldDelegate {
    // dismiss keyboard on return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
