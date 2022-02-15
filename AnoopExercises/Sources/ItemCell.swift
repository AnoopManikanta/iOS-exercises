//
//  TableViewCellStyling.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 11/02/22.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        nameLabel = addNameLabel()
        serialNumberLabel = addSerialNumberLabel()
        valueLabel = addValueLabel()
        
        contentView.backgroundColor = UIColor(named: "Color")
        contentView.addSubview(nameLabel)
        contentView.addSubview(serialNumberLabel)
        contentView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            serialNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            serialNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        serialNumberLabel.setContentHuggingPriority(UILayoutPriority.init(250), for: .vertical)
        serialNumberLabel.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(R.string.localizable.fatalError())
    }
}

func addNameLabel() -> UILabel {
    let nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
    nameLabel.adjustsFontForContentSizeCategory = true
    return nameLabel
}

func addSerialNumberLabel() -> UILabel {
    let serialNumberLabel = UILabel()
    serialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    serialNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    serialNumberLabel.adjustsFontForContentSizeCategory = true
    serialNumberLabel.textColor = .gray
    return serialNumberLabel
}
func addValueLabel() -> UILabel {
    let valueLabel = UILabel()
    valueLabel.translatesAutoresizingMaskIntoConstraints = false
    valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
    valueLabel.adjustsFontForContentSizeCategory = true
    return valueLabel
}
