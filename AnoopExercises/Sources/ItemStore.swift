//
//  ItemStore.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 11/02/22.
//

import UIKit

class ItemStore {
    var allItems = [Item] ()
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        print("s")
        return newItem
    }
    
    init() {
        for _ in 0..<5{
            createItem()
        }
    }
}
