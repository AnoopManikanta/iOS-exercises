//
//  MyView.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 09/02/22.
//

import Foundation
import UIKit

class ConversionView: UIView, UITextFieldDelegate{
    @IBOutlet var contentView: UIView!
    @IBOutlet var celciusLabel: UILabel?
    @IBOutlet var textField: UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ConversionView", owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    var farhenhietValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsius()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let farhenhietValue = farhenhietValue {
            return farhenhietValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    func updateCelsius() {
        if let celsiusValue = celsiusValue {
            celciusLabel?.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celciusLabel?.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeperator = string.range(of: ".")
        
        if existingTextHasDecimalSeperator != nil, replacementTextHasDecimalSeperator != nil {
            return false
        } else {
            return true
        }
        
    }
    
    @IBAction func farhenheitFieldEditingChanged(_ textField: UITextField){
        if let text = textField.text, let value = Double(text) {
            farhenhietValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            farhenhietValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField?.resignFirstResponder()
    }
}

extension UIView
{
    func fixInView(_ container: UIView) -> Void{
        container.addSubview(self)
//        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: container.topAnchor),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
}

