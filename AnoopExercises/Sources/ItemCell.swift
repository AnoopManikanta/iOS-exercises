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
        nameLabel = UILabel()
        serialNumberLabel = UILabel()
        valueLabel = UILabel()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        serialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(serialNumberLabel)
        contentView.addSubview(valueLabel)
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
        valueLabel.adjustsFontForContentSizeCategory = true
        
        serialNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 65),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            serialNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            serialNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        valueLabel.setContentHuggingPriority(UILayoutPriority.init(250), for: .vertical)
        valueLabel.setContentCompressionResistancePriority(UILayoutPriority.init(749), for: .vertical)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}
