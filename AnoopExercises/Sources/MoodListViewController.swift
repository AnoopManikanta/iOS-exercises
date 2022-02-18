//
//  MoodListViewController.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 15/02/22.
//

import UIKit

class MoodListViewController: UITableViewController {
    var moodEntries: [MoodEntry] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        let dateString = DateFormatter.localizedString(from: moodEntry.timestamp, dateStyle: .medium, timeStyle: .short)
        cell.detailTextLabel?.text = "on \(dateString)"
        return cell
    }
}

// append data to the table and update the tableView
extension MoodListViewController: MoodsConfigurable {
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.reloadData()
    }
}
