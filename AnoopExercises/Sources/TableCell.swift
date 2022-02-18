//
//  TableCell.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 15/02/22.
//

import UIKit

// custom tableCell class to define cell style
class TableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
