//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var fahrenhietLabel: UITextField?
    @IBOutlet var celsiusLabel: UILabel?
    
    var fahrenhietValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenhietValue = fahrenhietValue {
            return fahrenhietValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel?.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel?.text = R.string.localizable.questionLabel()
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeperator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementTextHasDecimalSeperator = string.range(of:decimalSeperator)
        
        if existingTextHasDecimalSeperator != nil, replacementTextHasDecimalSeperator != nil {
            return false
        } else {
            return true
        }
    }
    
    @objc func fahrenhietFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenhietValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenhietValue = nil
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        fahrenhietLabel?.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let marginGuide = view.layoutMarginsGuide
        fahrenhietLabel = fahrenhietTextField()
        guard let fahrenhietLabel = fahrenhietLabel else{
            return
        }
        
        let description1Text = R.string.localizable.conversionDescription1(preferredLanguages: ["\(Locale.current)"])
        let description1 = Label(text: description1Text, fontSize: 36, fontColor: UIColor.orange)
        
        let description2Text = R.string.localizable.conversionDescription2(preferredLanguages: ["\(Locale.current)"])
        let description2 = Label(text: description2Text, fontSize: 36)
        
        let celsiusLabelText = R.string.localizable.celsiusLabelText(preferredLanguages: ["\(Locale.current)"])
        celsiusLabel = Label(text: celsiusLabelText, fontSize: 70, fontColor: UIColor.orange)
        guard let celsiusLabel = celsiusLabel else {
            return
        }
        
        let description3Text = R.string.localizable.conversionDescription3(preferredLanguages: ["\(Locale.current)"])
        let description3 = Label(text: description3Text, fontSize: 36, fontColor: UIColor.orange)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        
        // adding all the labels to the view
        view.addGestureRecognizer(tapGesture)
        view.addSubview(fahrenhietLabel)
        view.addSubview(description1)
        view.addSubview(description2)
        view.addSubview(celsiusLabel)
        view.addSubview(description3)
        
        // update celsius label when the View is loaded
        updateCelsiusLabel()
        
        // adding target functionality to farhenhiet label
        fahrenhietLabel.addTarget(self, action: #selector(fahrenhietFieldEditingChanged(_:)), for: .editingChanged)
        fahrenhietLabel.delegate = self
        
        // Activating constraints for all labels
        NSLayoutConstraint.activate([
            fahrenhietLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20),
            fahrenhietLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            fahrenhietLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            fahrenhietLabel.heightAnchor.constraint(equalToConstant: fahrenhietLabel.intrinsicContentSize.height),
            description1.topAnchor.constraint(equalTo: fahrenhietLabel.bottomAnchor, constant: 8),
            description1.leadingAnchor.constraint(equalTo: fahrenhietLabel.leadingAnchor),
            description1.trailingAnchor.constraint(equalTo: fahrenhietLabel.trailingAnchor),
            description1.heightAnchor.constraint(equalToConstant: description1.intrinsicContentSize.height),
            description2.topAnchor.constraint(equalTo: description1.bottomAnchor, constant: 8),
            description2.leadingAnchor.constraint(equalTo: description1.leadingAnchor),
            description2.trailingAnchor.constraint(equalTo: description1.trailingAnchor),
            description2.heightAnchor.constraint(equalToConstant: description2.intrinsicContentSize.height),
            celsiusLabel.topAnchor.constraint(equalTo: description2.bottomAnchor, constant: 8),
            celsiusLabel.leadingAnchor.constraint(equalTo: description2.leadingAnchor),
            celsiusLabel.trailingAnchor.constraint(equalTo: description2.trailingAnchor),
            celsiusLabel.heightAnchor.constraint(equalToConstant: celsiusLabel.intrinsicContentSize.height),
            description3.topAnchor.constraint(equalTo: celsiusLabel.bottomAnchor, constant: 8),
            description3.leadingAnchor.constraint(equalTo: celsiusLabel.leadingAnchor),
            description3.trailingAnchor.constraint(equalTo: celsiusLabel.trailingAnchor),
            description3.heightAnchor.constraint(equalToConstant: description3.intrinsicContentSize.height)
        ])
    }
}

func Label(text: String, fontSize: CGFloat, fontColor: UIColor = UIColor.black) -> UILabel{
    let label = UILabel()
    label.text = text
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: fontSize)
    label.textColor = fontColor
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

func fahrenhietTextField() -> UITextField {
    let textField = UITextField()
    let placeholder = R.string.localizable.textFieldPlaceholder(preferredLanguages: ["\(Locale.current)"])
    textField.placeholder = placeholder
    textField.textColor = UIColor.orange
    textField.font = UIFont.systemFont(ofSize: 70)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textAlignment = .center
    textField.keyboardType = .decimalPad
    textField.autocorrectionType = .no
    textField.spellCheckingType = .no
    return textField
}
